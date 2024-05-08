//
//  ProfileBViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit

final class ProfileBViewController: UIViewController {
    let profileBView = ProfileBView()

    override func loadView() {
        view = profileBView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonTapped()
    }
}

// MARK: - private Methods

private extension ProfileBViewController {
    func setupButtonTapped() {
        profileBView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        
        profileBView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
    }
    
    @objc func yesButtonTapped() {
        profileBView.selectYesOrNo(neutrification: .yes)
    }
    
    @objc func noButtonTapped() {
        profileBView.selectYesOrNo(neutrification: .no)
    }
}
