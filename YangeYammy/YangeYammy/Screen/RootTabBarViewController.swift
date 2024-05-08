//
//  RootTabBarViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarItem()
    }
}

// MARK: - Private Methods

private extension RootTabBarViewController {
    func setupTabBar() {
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
    }
    
    func setupTabBarItem() {
        let alarmViewController = AlarmViewController()
        let alarmNavigationController = AlarmNavigationController(rootViewController: alarmViewController)
        alarmViewController.tabBarItem = UITabBarItem(title: "알람",
                                                      image: UIImage(systemName: "alarm"),
                                                      selectedImage: UIImage(systemName: "alarm.fill"))
        
        let profileViewController = ProfileContentViewController()
        let profileNavigationController = ProfileNavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem = UITabBarItem(title: "설정",
                                                      image: UIImage(systemName: "person.circle"),
                                                      selectedImage: UIImage(systemName: "person.circle.fill"))
        
        viewControllers = [alarmNavigationController,
                           profileNavigationController]
    }
}
