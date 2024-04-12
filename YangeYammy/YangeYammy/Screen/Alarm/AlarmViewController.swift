//
//  AlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class AlarmViewController: UIViewController {
    let alarmView = AlarmView()
    
    override func loadView() {
        super.loadView()
        view = alarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

private extension AlarmViewController {
    func setupNavigationBar() {
        self.title = "알람"
        
        let leftBarButton = UIBarButtonItem(title: "편집",
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonTapped))
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
        leftBarButton.tintColor = .systemOrange
        rightBarButton.tintColor = .systemOrange
        
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftBarButtonTapped() {
        if #available(iOS 14.0, *) {
            setEditing(alarmView.collectionView.isEditing, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func rightBarButtonTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AlarmNavigationController") as? AlarmNavigationController
    }
}
