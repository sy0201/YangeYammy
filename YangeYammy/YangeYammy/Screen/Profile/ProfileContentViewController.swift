//
//  ProfileContentViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit
import SnapKit

final class ProfileContentViewController: UIViewController {

    lazy var navigationView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        
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
    
    lazy var vc3: ProfileCViewController = {
        let vc3 = ProfileCViewController()
        
        return vc3
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
       return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension ProfileContentViewController {
    func setConstraint() {
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        navigationView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalTo(72)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        pageViewController.didMove(toParent: self)
    }
    
    func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
}

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
