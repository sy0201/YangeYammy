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
    var alarmData: [AlarmEntity] {
        get {
            return sortAlarmData()
        }
    }
    
    let alarmView = AlarmView()

    override func loadView() {
        view = alarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func sortAlarmData() -> [AlarmEntity] {
        let sortedArray = alarmManager.getAlarmList().sorted { (prev, next) -> Bool in
            var prevTime = "\(prev.time!)"
            var nextTime = "\(next.time!)"
            
            let prevTimeArray = prevTime.split(separator: " ")
            let nextTimeArray = nextTime.split(separator: " ")
            
            prevTime = "\(prevTimeArray[1])"
            nextTime = "\(nextTimeArray[1])"
            
            let prevTimeHourAndMinute = prevTime.split(separator: ":")
            let nextTimeHourAndMinute = nextTime.split(separator: ":")
            
            let prevTimeInt = prevTimeHourAndMinute.map { str in
                return Int(str)!
            }
            
            let nextTimeInt = nextTimeHourAndMinute.map { str in
                return Int(str)!
            }
            
            if(prevTimeInt[0] < nextTimeInt[0]){
                return true
            }else if(prevTimeInt[0] > nextTimeInt[0]){
                return false
            }else if(prevTimeInt[0] == nextTimeInt[0] && prevTimeInt[1] < nextTimeInt[1]){
                return true
            }else{
                return false
            }
        }
        
        return sortedArray
    }
}

// MARK: - Private Methods

private extension AlarmViewController {
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

        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - AlarmDelegate

extension AlarmViewController: AlarmDelegate {
    func updateAlarm() {
        alarmView.tableView.reloadData()
    }
}
