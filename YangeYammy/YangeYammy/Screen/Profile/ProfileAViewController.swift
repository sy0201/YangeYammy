//
//  ProfileAViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit

final class ProfileAViewController: UIViewController {
    let profileAView = ProfileAView()
    
    override func loadView() {
        super.loadView()
        view = profileAView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
