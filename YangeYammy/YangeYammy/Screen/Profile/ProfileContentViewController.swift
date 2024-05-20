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
    
    lazy var navigationView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegate()
        setConstraint()
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
    }
}

// MARK: - Private Methods

private extension ProfileContentViewController {
    func setupNavigationBar() {
        self.title = "Profile"
        
        let editBarButton = UIBarButtonItem(title: "수정",
                                            style: .plain,
                                            target: self,
                                            action: #selector(editBarButtonTapped))
        
        let profileSaveBarButton = UIBarButtonItem(title: "저장",
                                            style: .plain,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))
        
        editBarButton.tintColor = .systemGreen
        profileSaveBarButton.tintColor = .systemGreen
        
        self.navigationItem.leftBarButtonItem = editBarButton
        self.navigationItem.rightBarButtonItem = profileSaveBarButton
    }
    
    @objc func editBarButtonTapped() {
        self.dismiss(animated: true)
        let profileAViewController = ProfileAViewController()
        profileAViewController.modalPresentationStyle = .fullScreen
        present(profileAViewController, animated: true)
    }
    
    @objc func saveBarButtonTapped() {
        if let profileAViewController = dataViewControllers.first as? ProfileAViewController,
           let profileBViewController = dataViewControllers.last as? ProfileBViewController,
           profileAViewController.isProfileInfoComplete() && profileBViewController.isProfileInfoComplete() {
            
            let profileImage = profileAViewController.profileAView.profileImage.image?.toBase64() ?? ""
            let gender = profileAViewController.selectedGender?.rawValue ?? ""
            let name = profileAViewController.profileAView.name.text ?? ""
            let age = profileAViewController.profileAView.age.text ?? ""
            let weight = Float(profileAViewController.profileAView.weight.text ?? "") ?? 0.0
            let kcal = Int(profileAViewController.profileAView.kcal.text ?? "") ?? 0
            let neutrification = profileBViewController.selectedNeutrification?.rawValue ?? ""
            let bcs = profileBViewController.selectedBcsType?.rawValue ?? 0
            
            profileDataManager.saveProfile(profileImage: profileImage,
                                           gender: gender,
                                           name: name,
                                           age: age,
                                           weight: weight,
                                           kcal: kcal,
                                           neutrification: neutrification,
                                           bcs: bcs) {
                
                self.setupRandomAlarm(age: age)
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: nil, message: "프로필 정보를 모두 입력해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
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
    
    func setupRandomAlarm(age: String) {
        if let tabBarController = self.presentingViewController as? RootTabBarViewController,
           let alarmNavController = tabBarController.viewControllers?.first(where: { $0 is AlarmNavigationController }) as? AlarmNavigationController,
           let alarmViewController = alarmNavController.viewControllers.first as? AlarmViewController {
            
            if age == "1" || age == "13" {
                alarmViewController.createAlarm(at: "05:00", title: "1차 야미")
                alarmViewController.createAlarm(at: "10:00", title: "2차 야미")
                alarmViewController.createAlarm(at: "14:00", title: "3차 야미")
                alarmViewController.createAlarm(at: "19:00", title: "4차 야미")
            } else {
                alarmViewController.createAlarm(at: "06:00", title: "아침 야미")
                alarmViewController.createAlarm(at: "20:00", title: "저녁 야미")
            }
            tabBarController.selectedIndex = 0
        }
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
}
