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
    var alarmData: AlarmEntity?
    var notificationId: String = ""
    let createAlarmView = CreateAlarmView()

    override func loadView() {
        view = createAlarmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupNavigationBar()
        createAlarmView.delegate = self
    }
    
    func presentAlarmRepeatDetailViewController() {
        let selectDayVC = SelectDayViewController()
        navigationController?.pushViewController(selectDayVC, animated: true)
    }
}

// MARK: - Private Methods

private extension CreateAlarmViewController {
    func setupData() {
        NotificationService.shared.UNCurrentCenter.removeAllPendingNotificationRequests()
        
        if let alarmData = alarmData {
            notificationId = "\(getCurrentDateFromSimulator(date: alarmData.time!))"
        }
        
        createAlarmView.datePickerView.timeZone = TimeZone.current
    }
    
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
        delegate?.updateAlarm()

        if alarmData != nil {
            let newData = alarmData
            newData?.isOn = true
            newData?.time = createAlarmView.datePickerView.date
            newData?.label = ""
            newData?.isAgain = getIsAgain()
            newData?.repeatDays = getRepeatDays()
            
            alarmManager.updateAlarm(targetId: alarmData!.time!, newData: newData!) {
                self.setupData()
                self.delegate?.updateAlarm()
            }
        } else {
            alarmManager.saveAlarm(isOn: true, time: createAlarmView.datePickerView.date, label: "", isAgain: getIsAgain(), repeatDays: "") {
                self.setupData()
                self.delegate?.updateAlarm()
            }
            
            notificationId = "\(createAlarmView.datePickerView.date)"
        }
        
        NotificationService.shared.requestAlarmNotification(date: createAlarmView.datePickerView.date, title: "냥이야미", subTitle: "오늘도 맛있는 밥을 먹을게요", notificationId: notificationId, dataIndex: alarmManager.getAlarmList().count == 0 ? nil : alarmManager.getAlarmList().count, needToReloadTableView: createAlarmView.tableView, updateTarget: alarmData?.time)
        
        self.dismiss(animated: true)
    }
    
    // TODO: 다시 알림 Cell 추가
    func getIsAgain() -> Bool{
        guard let cell = createAlarmView.tableView.visibleCells.first as? RepeatedDateTableViewCell else {
            // 배열이 비어 있는 경우
            return false
        }
        return true
    }
    
    func getRepeatDays() -> String{
        let repeatCell = createAlarmView.tableView.visibleCells[0] as! DayTableViewCell
        
        if let text = repeatCell.dayLabel.text, text != "안 함"{
            return text
        }
        
        return ""
    }
}

// MARK: - PresentVCDelegate

extension CreateAlarmViewController: PresentVCDelegate {
    func presentViewController() {
        presentAlarmRepeatDetailViewController()
    }
}
