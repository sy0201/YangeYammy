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
    
    override func viewWillAppear(_ animated: Bool) {
        alarmView.alarmList = getAlarmList()
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
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addtBarButtonTapped))
        
        editBarButton.tintColor = .systemOrange
        addBarButton.tintColor = .systemOrange
        
        self.navigationItem.leftBarButtonItem = editBarButton
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func editBarButtonTapped() {
        if #available(iOS 14.0, *) {
            setEditing(alarmView.collectionView.isEditing, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func addtBarButtonTapped() {
        let createAlarmViewController = CreateAlarmViewController()
        let navigationController = UINavigationController(rootViewController: createAlarmViewController)
        createAlarmViewController.pickedDate = { [weak self] date in guard let self = self else { return }
            
            var alarmList = self.getAlarmList()
            let newAlert = AlarmModel(date: date, isOn: true)
            
            alarmList.append(newAlert)
            alarmList.sort { $0.date < $1.date }
            
            alarmView.alarmList = alarmList
            UserDefaults.standard.set(try? PropertyListEncoder().encode(alarmView.alarmList), forKey: "alarms")
            alarmView.collectionView.reloadData()
        }
        present(navigationController, animated: true, completion: nil)
    }
    
    func getAlarmList() -> [AlarmModel] {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              let alerts = try? PropertyListDecoder().decode([AlarmModel].self, from: data) else { return [] }
        return alerts
    }
}
