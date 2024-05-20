//
//  ProfileListViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 5/20/24.
//

import UIKit

final class ProfileListViewController: UIViewController {
    var profileManager = ProfileDataManager.shared

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
        
        addBarButton.tintColor = .systemOrange
        
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func addBarButtonTapped() {
        let profileContentViewController = ProfileContentViewController()
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
        profileManager.getProfile().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileListCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let profileData = profileManager.getProfile()[indexPath.row]
        cell.configure(with: profileData)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - 3 * 10) / 2
        return CGSize(width: width, height: 100)
    }
}
