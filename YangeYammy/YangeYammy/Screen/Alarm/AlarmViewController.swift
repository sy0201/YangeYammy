//
//  AlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit
import SnapKit

final class AlarmViewController: UIViewController {
    var alarmManager = AlarmManager.shared
    
    let alarmView = AlarmView()

    override func loadView() {
        view = alarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupNavigationBar()
    }
}

// MARK: - Private Methods

private extension AlarmViewController {
    func setupData() {
        alarmView.alarmManager = alarmManager
    }
    
    func setupNavigationBar() {
        self.title = "알람"
        
        let editBarButton = UIBarButtonItem(title: "편집",
                                            style: .plain,
                                            target: self,
                                            action: #selector(editBarButtonTapped))
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
        
        editBarButton.tintColor = .systemOrange
        addBarButton.tintColor = .systemOrange
        
        self.navigationItem.leftBarButtonItem = editBarButton
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func editBarButtonTapped() {
        if #available(iOS 14.0, *) {
            setEditing(alarmView.tableView.isEditing, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func addBarButtonTapped() {
        let createAlarmViewController = CreateAlarmViewController()
        createAlarmViewController.delegate = self
                
        let navigationController = UINavigationController(rootViewController: createAlarmViewController)
        
        createAlarmViewController.pickedDate = { [weak self] date in guard let self = self else { return }
            
            let newAlert = AlarmModel(date: date, isOn: true, repeatedDays: [])
            
            self.alarmView.userNotificationCenter.addNotificationRequest(by: newAlert)
            self.alarmManager.saveAlarm(date: newAlert.date, isOn: newAlert.isOn, repeatedDays: newAlert.repeatedDays)
            
            alarmView.tableView.reloadData()
        }
        present(navigationController, animated: true, completion: nil)
    }
}

extension AlarmViewController: AlarmDelegate {
    func addNewAlarm(_ alarm: AlarmManager) {
        alarmView.tableView.reloadData()
    }
    
    func updateAlarm(_ alarm: AlarmManager) {
        alarmView.tableView.reloadData()
    }
}
