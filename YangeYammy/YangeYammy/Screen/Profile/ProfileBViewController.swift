//
//  ProfileBViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit

final class ProfileBViewController: UIViewController {
    let profileBView = ProfileBView()
    var selectedBcsType: BcsType?
    var selectedNeutrification: Neutrification?
    
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
        
        profileBView.bcs1Button.addTarget(self, action: #selector(bcs1ButtonTapped), for: .touchUpInside)
        
        profileBView.bcs2Button.addTarget(self, action: #selector(bcs2ButtonTapped), for: .touchUpInside)
        
        profileBView.bcs3Button.addTarget(self, action: #selector(bcs3ButtonTapped), for: .touchUpInside)
        
        profileBView.bcs4Button.addTarget(self, action: #selector(bcs4ButtonTapped), for: .touchUpInside)
        
        profileBView.bcs5Button.addTarget(self, action: #selector(bcs5ButtonTapped), for: .touchUpInside)
    }
    
    @objc func yesButtonTapped() {
        selectedNeutrification = .yes
        profileBView.selectYesOrNo(neutrification: .yes)
    }
    
    @objc func noButtonTapped() {
        selectedNeutrification = .no
        profileBView.selectYesOrNo(neutrification: .no)
    }
    
    @objc func bcs1ButtonTapped() {
        selectedBcsType = .bcs1
        profileBView.selectBcs(bcs: .bcs1)
    }
    
    @objc func bcs2ButtonTapped() {
        selectedBcsType = .bcs2
        profileBView.selectBcs(bcs: .bcs2)
    }
    
    @objc func bcs3ButtonTapped() {
        selectedBcsType = .bcs3
        profileBView.selectBcs(bcs: .bcs3)
    }
    
    @objc func bcs4ButtonTapped() {
        selectedBcsType = .bcs4
        profileBView.selectBcs(bcs: .bcs4)
    }
    
    @objc func bcs5ButtonTapped() {
        selectedBcsType = .bcs5
        profileBView.selectBcs(bcs: .bcs5)
    }
}
