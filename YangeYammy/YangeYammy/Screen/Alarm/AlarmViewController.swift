//
//  AlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class AlarmViewController: UIViewController {
    var alarmManager = AlarmDataManager.shared
    weak var delegate: AlarmDelegate?

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
        setupTableView()
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
            
            if (prevTimeInt[0] < nextTimeInt[0]) {
                return true
            } else if (prevTimeInt[0] > nextTimeInt[0]) {
                return false
            } else if (prevTimeInt[0] == nextTimeInt[0] && prevTimeInt[1] < nextTimeInt[1]) {
                return true
            } else {
                return false
            }
        }
        
        return sortedArray
    }
    
    func createAlarm(at time: String, title: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        guard let date = dateFormatter.date(from: time) else { 
            return }
        
        alarmManager.saveAlarm(isOn: true, 
                               time: date,
                               label: title,
                               isAgain: true,
                               repeatDays: "") {
            DispatchQueue.main.async {
                self.alarmView.tableView.reloadData()
            }
        }
        
        let notificationId = "\(date)"
        NotificationService.shared.requestAlarmNotification(date: date, title: title, subTitle: "추천 알람", notificationId: notificationId, dataIndex: alarmManager.getAlarmList().count, updateTarget: nil)
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
        let editing = !alarmView.tableView.isEditing
        alarmView.tableView.setEditing(editing, animated: true)
    }
    
    @objc func addBarButtonTapped() {
        let createAlarmViewController = CreateAlarmViewController()
        createAlarmViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: createAlarmViewController)
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func setupTableView() {
        alarmView.tableView.dataSource = self
        alarmView.tableView.delegate = self
        
        alarmView.tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewController Protocol

extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarmManager.getAlarmList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.reuseIdentifier, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell() }
        
        let alarmList = alarmManager.getAlarmList()
        let alarm = alarmList[indexPath.row]
        
        cell.alarmData = alarm
        cell.switchDelegate = self
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let removeAlarm = alarmManager.getAlarmList()[indexPath.row]
            alarmManager.removeAlarm(deleteTarget: removeAlarm) {
            }

            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let deletedAlarmId = String(describing: removeAlarm.id)
            NotificationService.shared.removeNotification(withIdentifier: deletedAlarmId)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - AlarmDelegate

extension AlarmViewController: AlarmDelegate {
    func updateAlarm() {
        alarmView.tableView.reloadData()
    }
}

// MARK: - SwitchValueDelegate

extension AlarmViewController: SwitchValueDelegate {
    func switchValueChanged(isOn: Bool) {
        print("Switch value changed: \(isOn)")
    }
}
