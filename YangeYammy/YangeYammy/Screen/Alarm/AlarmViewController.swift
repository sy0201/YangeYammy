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
        setupNavigationBar()
        setupData()
    }
}

// MARK: - Private Methods

private extension AlarmViewController {
    func setupData() {
        alarmManager.getAlarmList()
        alarmView.tableView.reloadData()
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

        present(navigationController, animated: true, completion: nil)
    }
}

extension AlarmViewController: AlarmDelegate {
    func addNewAlarm(_ alarm: AlarmModel) {
        //TODO: 전체 테이블 뷰를 새로고침하기때문에 다른 방법 찾기
        //alarmManager.saveAlarm(date: alarm.date, isOn: alarm.isOn, repeatedDays: alarm.repeatedDays)
        alarmView.tableView.reloadData()
    }
    
    func updateAlarm(_ alarm: AlarmModel) {
        alarmManager.getAlarmList()
        alarmView.tableView.reloadData()
    }
    
    func reloadAlarmView() {
        alarmView.tableView.reloadData()
    }
}
