//
//  ProfileDetailViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 5/21/24.
//

import UIKit

final class ProfileDetailViewController: UIViewController {
    weak var delegate: ProfileSelectionDelegate?
    var profileData: ProfileEntity?
    
    let profileDetailView = ProfileDetailView()
    
    override func loadView() {
        view = profileDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func didSelectDetailProfile(_ profile: ProfileEntity) {
        self.profileData = profile
        updateUI()
    }
    
    private func updateUI() {
        guard isViewLoaded, let profileData = profileData else { 
            return }
        
        if let profileImageString = profileData.profileImage,
           let profileImage = UIImage(base64String: profileImageString) {
            profileDetailView.profileImage.image = profileImage
        } else {
            // Handle case where profile image is not available
            profileDetailView.profileImage.image = nil
        }
        profileDetailView.genderLabel.text = profileData.gender
        profileDetailView.ageLabel.text = profileData.age
        profileDetailView.nameLabel.text = profileData.name
        profileDetailView.weightLabel.text = "\(profileData.weight)"
        profileDetailView.kcalLabel.text = "\(profileData.kcal)"
        profileDetailView.neutrificationLabel.text = profileData.neutrification
        profileDetailView.bcsLabel.text = "\(profileData.bcs)"
    }
}
