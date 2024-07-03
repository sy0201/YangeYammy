//
//  ProfileContentViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//
 
import UIKit
import SnapKit

final class ProfileContentViewController: UIViewController {
    let profileDataManager = ProfileDataManager.shared
    weak var delegate: ProfileSelectionDelegate?
    var profileData: ProfileEntity?

    lazy var navigationView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageVC.delegate = self
        pageVC.dataSource = self
        return pageVC
    }()
    
    lazy var vc1: ProfileAViewController = {
        let vc1 = ProfileAViewController()
        return vc1
    }()
    
    lazy var vc2: ProfileBViewController = {
        let vc2 = ProfileBViewController()
        return vc2
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2]
    }()
    
    let profileListView = ProfileListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegate()
        setConstraint()
        setupPageVC()
    }
    
    func setupPageVC() {
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            updateSaveButtonTitle(for: firstVC)
        }
    }
    
    func configure(with profile: ProfileEntity, gender: String, neutrification: Neutrification?, bcsType: BcsType?) {
        self.profileData = profile
        let selectedGender = Gender(rawValue: gender) ?? .female
        vc1.configure(with: profile, gender: selectedGender)
        
        if let neutrification = neutrification,
           let bcsType = bcsType {
            vc2.configure(with: profile, neutrification: neutrification, bcs: bcsType)
        }
    }
    
    func updateSaveButtonTitle(for viewController: UIViewController) {
        if viewController is ProfileAViewController {
            self.navigationItem.rightBarButtonItem?.title = "다음"
        } else if viewController is ProfileBViewController {
            self.navigationItem.rightBarButtonItem?.title = "저장"
        }
    }
}

// MARK: - Private Methods

private extension ProfileContentViewController {
    func setupNavigationBar() {
        self.title = "반려동물 정보입력"
        
        let deleteBarButton = UIBarButtonItem(title: "삭제",
                                            style: .plain,
                                            target: self,
                                            action: #selector(deleteBarButtonTapped))
        
        let profileSaveBarButton = UIBarButtonItem(title: "저장",
                                            style: .plain,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))
        
        deleteBarButton.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        profileSaveBarButton.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        
        self.navigationItem.leftBarButtonItem = deleteBarButton
        self.navigationItem.rightBarButtonItem = profileSaveBarButton
    }
    
    @objc func deleteBarButtonTapped() {
        if let profileData = profileData {
            profileDataManager.removeProfile(deleteTarget: profileData) {
                self.delegate?.editProfile(profileData)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func saveBarButtonTapped() {
        if let visibleViewController = pageViewController.viewControllers?.first {
            if visibleViewController is ProfileAViewController {
                if dataViewControllers.count > 1 {
                    let nextVC = dataViewControllers[1]
                    pageViewController.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] _ in
                        self?.updateSaveButtonTitle(for: nextVC)
                    }
                }
            } else if visibleViewController is ProfileBViewController {
                if let profileAViewController = dataViewControllers.first as? ProfileAViewController,
                   let profileBViewController = dataViewControllers.last as? ProfileBViewController,
                   profileAViewController.isProfileInfoComplete() && profileBViewController.isProfileInfoComplete() {
                    
                    let profileImage = profileAViewController.profileAView.profileImage.image?.toBase64()
                    let gender = profileAViewController.genderType?.rawValue ?? ""
                    let name = profileAViewController.profileAView.name.text ?? ""
                    let birthYear = Int(profileAViewController.profileAView.year.text ?? "") ?? 0
                    let birthMonth = Int(profileAViewController.profileAView.month.text ?? "") ?? 0
                    let weight = Float(profileAViewController.profileAView.weight.text ?? "") ?? 0.0
                    let kcal = Int(profileAViewController.profileAView.kcal.text ?? "") ?? 0
                    
                    let neutrification = profileBViewController.neutrificationType?.rawValue ?? ""
                    let bcs = profileBViewController.bcsType?.rawValue ?? 0
                    
                    if let profileData = profileData {
                        profileData.profileImage = profileImage
                        profileData.gender = gender
                        profileData.name = name
                        profileData.birthYear = Int16(birthYear)
                        profileData.birthMonth = Int16(birthMonth)
                        profileData.weight = weight
                        profileData.kcal = Int16(kcal)
                        profileData.neutrification = neutrification
                        profileData.bcs = Int16(bcs)
                        
                        profileDataManager.updateProfile(profile: profileData) {
                            DispatchQueue.main.async {
                                self.delegate?.editProfile(profileData)
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    } else {
                        let alertController = UIAlertController(title: nil, message: "자동 사료 알람을 설정하시겠습니까?", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                            // Call saveProfile function
                            self.profileDataManager.saveProfile(profileImage: profileImage ?? "",
                                                                gender: gender,
                                                                name: name,
                                                                birthYear: birthYear,
                                                                birthMonth: birthMonth,
                                                                weight: weight,
                                                                kcal: Int(kcal),
                                                                neutrification: neutrification,
                                                                bcs: Int(bcs)
                            ) { newProfile in
                                if let newProfile = newProfile {
                                    self.delegate?.saveNewProfile(newProfile)
                                    
                                    let ageInMonths = self.calculateAgeInMonths(birthYear: birthYear, birthMonth: birthMonth)
                                    self.setupRandomAlarm(ageInMonths: ageInMonths)
                                    
                                    DispatchQueue.main.async {
                                        self.dismiss(animated: true)
                                    }
                                } else {
                                    print("Failed to save new profile")
                                }
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        present(alertController, animated: true, completion: nil)
                    }
                    
                } else {
                    let alertController = UIAlertController(title: nil, message: "프로필 정보를 모두 입력해주세요.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /**
    @objc func saveBarButtonTapped() {
        if let profileAViewController = dataViewControllers.first as? ProfileAViewController,
           let profileBViewController = dataViewControllers.last as? ProfileBViewController,
           profileAViewController.isProfileInfoComplete() && profileBViewController.isProfileInfoComplete() {
            
            let profileImage = profileAViewController.profileAView.profileImage.image?.toBase64()
            let gender = profileAViewController.genderType?.rawValue ?? ""
            let name = profileAViewController.profileAView.name.text ?? ""
            let birthYear = Int(profileAViewController.profileAView.year.text ?? "") ?? 0
            let birthMonth = Int(profileAViewController.profileAView.month.text ?? "") ?? 0
            let weight = Float(profileAViewController.profileAView.weight.text ?? "") ?? 0.0
            let kcal = Int(profileAViewController.profileAView.kcal.text ?? "") ?? 0

            let neutrification = profileBViewController.neutrificationType?.rawValue ?? ""
            let bcs = profileBViewController.bcsType?.rawValue ?? 0

            if let profileData = profileData {
                profileData.profileImage = profileImage
                profileData.gender = gender
                profileData.name = name
                profileData.birthYear = Int16(birthYear)
                profileData.birthMonth = Int16(birthMonth)
                profileData.weight = weight
                profileData.kcal = Int16(kcal)
                profileData.neutrification = neutrification
                profileData.bcs = Int16(bcs)
                
                profileDataManager.updateProfile(profile: profileData) {
                    DispatchQueue.main.async {
                        self.delegate?.editProfile(profileData)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            } else {
                let alertController = UIAlertController(title: nil, message: "자동 사료 알람을 설정하시겠습니까?", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                    // Call saveProfile function
                    self.profileDataManager.saveProfile(profileImage: profileImage ?? "",
                                                        gender: gender,
                                                        name: name,
                                                        birthYear: birthYear,
                                                        birthMonth: birthMonth,
                                                        weight: weight,
                                                        kcal: Int(kcal),
                                                        neutrification: neutrification,
                                                        bcs: Int(bcs)
                    ) { newProfile in
                        if let newProfile = newProfile {
                            self.delegate?.saveNewProfile(newProfile)
                        
                            let ageInMonths = self.calculateAgeInMonths(birthYear: birthYear, birthMonth: birthMonth)
                            self.setupRandomAlarm(ageInMonths: ageInMonths)
                            
                            DispatchQueue.main.async {
                                self.dismiss(animated: true)
                            }
                        } else {
                            print("Failed to save new profile")
                        }
                    }
                }
                
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

                alertController.addAction(okAction)
                alertController.addAction(cancelAction)

                present(alertController, animated: true, completion: nil)
            }
            
        } else {
            let alertController = UIAlertController(title: nil, message: "프로필 정보를 모두 입력해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    */
    
    func setConstraint() {
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        navigationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(72)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        pageViewController.didMove(toParent: self)
    }
    
    func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    func calculateAgeInMonths(birthYear: Int, birthMonth: Int) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let birthDateComponents = DateComponents(year: birthYear, month: birthMonth)
        
        guard let birthDate = calendar.date(from: birthDateComponents) else {
            return 0
        }
        
        let ageComponents = calendar.dateComponents([.year, .month], from: birthDate, to: currentDate)
        
        if let years = ageComponents.year, let months = ageComponents.month {
            return years * 12 + months
        }
        
        return 0
    }
    
    func setupRandomAlarm(ageInMonths: Int) {
        if let tabBarController = self.presentingViewController as? RootTabBarViewController,
           let alarmNavController = tabBarController.viewControllers?.first(where: { $0 is AlarmNavigationController }) as? AlarmNavigationController,
           let alarmViewController = alarmNavController.viewControllers.first as? AlarmViewController {
            
            let interval = (ageInMonths >= 1 && ageInMonths <= 12 || ageInMonths >= 156) ? 4 : 12
            let randomTimes = generateRandomTimes(interval: interval)
            
            if (ageInMonths >= 1 && ageInMonths <= 12 || ageInMonths >= 156) {
                alarmViewController.createAlarm(at: randomTimes[0], title: "1차 야미")
                alarmViewController.createAlarm(at: randomTimes[1], title: "2차 야미")
                alarmViewController.createAlarm(at: randomTimes[2], title: "3차 야미")
                alarmViewController.createAlarm(at: randomTimes[3], title: "4차 야미")
            } else {
                alarmViewController.createAlarm(at: randomTimes[0], title: "아침 야미")
                alarmViewController.createAlarm(at: randomTimes[1], title: "저녁 야미")
            }
            tabBarController.selectedIndex = 0
        }
    }
    
    func generateRandomTimes(interval: Int) -> [String] {
        var times: [String] = []
        let calendar = Calendar.current
        
        for _ in 0..<2 {
            let hour = Int.random(in: 1...24)
            let minute = [0, 30].randomElement()!
            if let randomDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let timeString = formatter.string(from: randomDate)
                times.append(timeString)
                
                if let laterDate = calendar.date(byAdding: .hour, value: interval, to: randomDate) {
                    let laterTimeString = formatter.string(from: laterDate)
                    times.append(laterTimeString)
                }
            }
        }
        
        return times
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension ProfileContentViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else {
            return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else {
            return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first {
            updateSaveButtonTitle(for: visibleViewController)
        }
    }
}
