//
//  ProfileListViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 5/20/24.
//

import UIKit

final class ProfileListViewController: UIViewController {
    var profileManager = ProfileDataManager.shared
    var profileContentViewController: ProfileContentViewController?

    let profileListView = ProfileListView()
    
    override func loadView() {
        view = profileListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
}

// MARK: - Private Methods

private extension ProfileListViewController {
    func setupNavigationBar() {
        self.title = "나의 반려동물"
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
        
        addBarButton.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func addBarButtonTapped() {
        let profileContentViewController = ProfileContentViewController()
        profileContentViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: profileContentViewController)

        present(navigationController, animated: true, completion: nil)
    }
    
    func setupCollectionView() {
        profileListView.collectionView.dataSource = self
        profileListView.collectionView.delegate = self
        
        profileListView.collectionView.register(ProfileListCollectionViewCell.self, forCellWithReuseIdentifier: ProfileListCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ProfileListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profileManager.getProfileList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileListCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let profileData = profileManager.getProfileList()[indexPath.row]
        cell.configure(with: profileData)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - 3 * 10) / 2
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileDetailVC = ProfileContentViewController()
        let profileData = profileManager.getProfileList()[indexPath.row]
        profileDetailVC.profileData = profileData
        profileDetailVC.delegate = self
        
        let gender = Gender(rawValue: profileData.gender ?? "") ?? .female
        let selectedNeutrification = Neutrification(rawValue: profileData.neutrification ?? "") ?? .no
        let selectedBcsType = BcsType(rawValue: Int(profileData.bcs)) ?? .bcs1
        
        profileDetailVC.configure(with: profileData, gender: gender.rawValue, neutrification: selectedNeutrification, bcsType: selectedBcsType)
        
        let navigationController = UINavigationController(rootViewController: profileDetailVC)
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - ProfileSelectionDelegate

extension ProfileListViewController: ProfileSelectionDelegate {
    func saveNewProfile(_ profile: ProfileEntity) {
        DispatchQueue.main.async {
            self.profileListView.collectionView.reloadData()
        }
    }
    
    func editProfile(_ profile: ProfileEntity) {
        if let index = profileManager.getProfileList().firstIndex(where: { $0.id == profile.id }) {
            profileManager.updateProfile(profile: profile) {
                DispatchQueue.main.async {
                    self.profileListView.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                }
            }
        } else {
            // 새로운 프로필을 추가하는 경우
            DispatchQueue.main.async {
                self.profileListView.collectionView.reloadData()
            }
        }
    }
}
