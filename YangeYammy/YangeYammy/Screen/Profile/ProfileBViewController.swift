//
//  ProfileBViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit

final class ProfileBViewController: UIViewController {
    var neutrificationType: Neutrification?
    var bcsType: BcsType?
    
    let profileBView = ProfileBView()
    
    override func loadView() {
        view = profileBView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonTapped()
    }
    
    func isProfileInfoComplete() -> Bool {
        let isNeutrificationSelected = profileBView.isNeutrificationTapped
        let isBcsSelected = profileBView.isBcsTapped
        
        print("isNeutrificationSelected \(isNeutrificationSelected)")
        print("isBcsSelected \(isBcsSelected)")

        return isNeutrificationSelected && isBcsSelected
    }
    
    func configure(with profile: ProfileEntity, neutrification: Neutrification, bcs: BcsType) {
        self.neutrificationType = neutrification
        profileBView.selectNeutrification(neutrification: Neutrification(rawValue: neutrificationType?.rawValue ?? "") ?? .no)
        
        self.bcsType = bcs
        profileBView.selectBcs(bcs: BcsType(rawValue: bcsType?.rawValue ?? 0) ?? .bcs1)
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
        neutrificationType = .yes
        profileBView.isNeutrificationTapped = true
        profileBView.selectNeutrification(neutrification: .yes)
    }
    
    @objc func noButtonTapped() {
        neutrificationType = .no
        profileBView.isNeutrificationTapped = true
        profileBView.selectNeutrification(neutrification: .no)
    }
    
    @objc func bcs1ButtonTapped() {
        bcsType = .bcs1
        profileBView.isBcsTapped = true
        profileBView.selectBcs(bcs: .bcs1)
    }
    
    @objc func bcs2ButtonTapped() {
        bcsType = .bcs2
        profileBView.isBcsTapped = true
        profileBView.selectBcs(bcs: .bcs2)
    }
    
    @objc func bcs3ButtonTapped() {
        bcsType = .bcs3
        profileBView.isBcsTapped = true
        profileBView.selectBcs(bcs: .bcs3)
    }
    
    @objc func bcs4ButtonTapped() {
        bcsType = .bcs4
        profileBView.isBcsTapped = true
        profileBView.selectBcs(bcs: .bcs4)
    }
    
    @objc func bcs5ButtonTapped() {
        bcsType = .bcs5
        profileBView.isBcsTapped = true
        profileBView.selectBcs(bcs: .bcs5)
    }
}
