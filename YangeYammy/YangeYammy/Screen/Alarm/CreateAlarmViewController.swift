//
//  CreateAlarmViewController.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

final class CreateAlarmViewController: UIViewController {
    let alarmManager = AlarmDataManager.shared
    weak var delegate: AlarmDelegate?
    var switchAgain: Bool = true
    var selectedDays: [Day] = []
    var textFieldLabel: String = ""
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createAlarmView.endEditing(true)
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
        let switchButtonAgain = switchAgain
        let repeatDaysString = selectedDays.map { $0.rawValue }.joined(separator: ", ")
        
        if alarmData != nil {
            let newData = alarmData
            newData?.isOn = true
            newData?.time = createAlarmView.datePickerView.date
            newData?.label = ""
            newData?.isAgain = switchButtonAgain
            newData?.repeatDays = repeatDaysString
            
            alarmManager.updateAlarm(targetId: alarmData!.time!, newData: newData!) {
                self.delegate?.updateAlarm()
            }
            
        } else {
            alarmManager.saveAlarm(isOn: true,
                                   time: createAlarmView.datePickerView.date,
                                   label: textFieldLabel,
                                   isAgain: switchButtonAgain,
                                   repeatDays: repeatDaysString) {
                self.delegate?.updateAlarm()
            }
            
            print("textFieldLabel \(textFieldLabel)")
            notificationId = "\(createAlarmView.datePickerView.date)"
        }
        
        NotificationService.shared.requestAlarmNotification(date: createAlarmView.datePickerView.date, title: "냥이야미", subTitle: "오늘도 맛있는 밥을 먹을게요", notificationId: notificationId, dataIndex: alarmManager.getAlarmList().count == 0 ? nil : alarmManager.getAlarmList().count, updateTarget: alarmData?.time)
        
        self.dismiss(animated: true)
    }
}

// MARK: - private Methods

private extension CreateAlarmViewController {
    func setupTableView() {
        createAlarmView.tableView.dataSource = self
        createAlarmView.tableView.delegate = self
        
        createAlarmView.tableView.register(SetRepeatDateTableViewCell.self, forCellReuseIdentifier: SetRepeatDateTableViewCell.reuseIdentifier)
        createAlarmView.tableView.register(SetLabelTableViewCell.self, forCellReuseIdentifier: SetLabelTableViewCell.reuseIdentifier)
        createAlarmView.tableView.register(SetRepeatAgainTableViewCell.self, forCellReuseIdentifier: SetRepeatAgainTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewController Protocol

extension CreateAlarmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SetRepeatDateTableViewCell.reuseIdentifier, for: indexPath) as? SetRepeatDateTableViewCell else {
                return UITableViewCell() }
            
            cell.dayDelegate = self
            cell.configure(with: selectedDays)
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SetLabelTableViewCell.reuseIdentifier, for: indexPath) as? SetLabelTableViewCell else {
                return UITableViewCell() }
            
            cell.delegate = self
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SetRepeatAgainTableViewCell.reuseIdentifier, for: indexPath) as? SetRepeatAgainTableViewCell else {
                return UITableViewCell() }
            
            cell.switchDelegate = self
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let selectDayVC = SelectDayViewController()
            selectDayVC.selectDayDelegate = self
            navigationController?.pushViewController(selectDayVC, animated: true)
        default:
            break
        }
    }
}

// MARK: - DayTableViewCellDelegate

extension CreateAlarmViewController: DayTableViewCellDelegate {
    func didSelectDay(_ day: [Day]) {
        selectedDays = day
        createAlarmView.tableView.reloadData()
    }
}

// MARK: - LabelTableViewCellDelegate

extension CreateAlarmViewController: LabelTableViewCellDelegate {
    func textFieldDidChange(text: String?) {
        textFieldLabel = text ?? ""
    }
}

// MARK: - SwitchValueDelegate

extension CreateAlarmViewController: SwitchValueDelegate {
    func switchValueChanged(isOn: Bool) {
        print("Switch value changed: \(isOn)")
    }
}
