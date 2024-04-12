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
        tabBar.tintColor = .black
    }
    
    func setupTabBarItem() {
        let alarmViewController = AlarmViewController()
        let alarmNavigationController = AlarmNavigationController(rootViewController: alarmViewController)
        alarmViewController.tabBarItem = UITabBarItem(title: "alarm",
                                                      image: UIImage(systemName: "alarm"),
                                                      selectedImage: UIImage(systemName: "alarm.fill"))
        viewControllers = [alarmNavigationController]
    }
}
