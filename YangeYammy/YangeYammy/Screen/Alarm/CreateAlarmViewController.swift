//
//  CreateAlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class CreateAlarmViewController: UIViewController {
    let alarmManager = AlarmManager.shared
    weak var delegate: AlarmDelegate?
    var selectedDays: [Day] = []
    var alarmData: AlarmEntity?
    var notificationId: String = ""
    
    let createAlarmView = CreateAlarmView()

    override func loadView() {
        view = createAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
}

// MARK: - Private Methods

private extension CreateAlarmViewController {
    func setupNavigationBar() {
        self.title = "알람추가"
        
        let cancelBarButton = UIBarButtonItem(title: "취소",
                                            style: .plain,
                                            target: self,
                                            action: #selector(cancelBarButtonTapped))
        let saveBarButton = UIBarButtonItem(title: "저장",
                                            style: .plain,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))

        cancelBarButton.tintColor = .systemOrange
        saveBarButton.tintColor = .systemOrange
        
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func saveBarButtonTapped() {
        let repeatDaysString = selectedDays.map { $0.rawValue }.joined(separator: ", ")
        
        if alarmData != nil {
            let newData = alarmData
            newData?.isOn = true
            newData?.time = createAlarmView.datePickerView.date
            newData?.label = ""
            newData?.isAgain = getIsAgain()
            newData?.repeatDays = repeatDaysString
            
            alarmManager.updateAlarm(targetId: alarmData!.time!, newData: newData!) {
                self.delegate?.updateAlarm()
            }
            
        } else {
            alarmManager.saveAlarm(isOn: true,
                                   time: createAlarmView.datePickerView.date,
                                   label: "",
                                   isAgain: getIsAgain(),
                                   repeatDays: repeatDaysString) {
                self.delegate?.updateAlarm()
            }
            
            notificationId = "\(createAlarmView.datePickerView.date)"
        }
        
        NotificationService.shared.requestAlarmNotification(date: createAlarmView.datePickerView.date, title: "냥이야미", subTitle: "오늘도 맛있는 밥을 먹을게요", notificationId: notificationId, dataIndex: alarmManager.getAlarmList().count == 0 ? nil : alarmManager.getAlarmList().count, updateTarget: alarmData?.time)
        
        self.dismiss(animated: true)
    }
    
    // TODO: 다시 알림 Cell 추가
    func getIsAgain() -> Bool {
        guard let cell = createAlarmView.tableView.visibleCells.first as? RepeatedDateTableViewCell else {
            // 배열이 비어 있는 경우
            return false
        }
        return true
    }
}

// MARK: - private Methods

private extension CreateAlarmViewController {
    func setupTableView() {
        createAlarmView.tableView.dataSource = self
        createAlarmView.tableView.delegate = self
        
        createAlarmView.tableView.register(RepeatedDateTableViewCell.self, forCellReuseIdentifier: RepeatedDateTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewController Protocol

extension CreateAlarmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepeatedDateTableViewCell.reuseIdentifier, for: indexPath) as? RepeatedDateTableViewCell else {
            return UITableViewCell() }
        
        cell.dayDelegate = self
        cell.configure(with: selectedDays)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectDayVC = SelectDayViewController()
        selectDayVC.selectDayDelegate = self
        navigationController?.pushViewController(selectDayVC, animated: true)
    }
}

// MARK: - DayTableViewCellDelegate

extension CreateAlarmViewController: DayTableViewCellDelegate {
    func didSelectDay(_ day: [Day]) {
        selectedDays = day
        createAlarmView.tableView.reloadData()
    }
}
