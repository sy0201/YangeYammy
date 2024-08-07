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
    var switchOnOff: Bool = true
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
        setupData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createAlarmView.endEditing(true)
    }
    
    func setupData() {
        if let alarmData = alarmData {
            createAlarmView.datePickerView.setDate(alarmData.time ?? Date(), animated: false)
            selectedDays = parseRepeatDays(alarmData.repeatDays ?? "")
            textFieldLabel = alarmData.label ?? ""
            switchAgain = alarmData.isAgain
            switchOnOff = alarmData.isOn
            createAlarmView.tableView.reloadData()
        }
    }
    
    func parseRepeatDays(_ repeatDays: String) -> [Day] {
        return repeatDays.split(separator: ",").compactMap { Day(rawValue: String($0).trimmingCharacters(in: .whitespaces)) }
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

        cancelBarButton.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        saveBarButton.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func saveBarButtonTapped() {
        let alarmOnOff = switchOnOff
        let switchButtonAgain = switchAgain
        let repeatDaysString: String
        if selectedDays.isEmpty {
            repeatDaysString = "Everyday" // 빈 문자열은 매일 반복을 나타냄

        } else {
            repeatDaysString = selectedDays.map { $0.rawValue }.joined(separator: ", ")
        }
        let alarmDate = createAlarmView.datePickerView.date
        let alarmLabel = textFieldLabel
        
        guard alarmManager.context != nil else { return }
        
        if let alarmData = alarmData {
            alarmData.isOn = alarmOnOff
            alarmData.time = alarmDate
            alarmData.label = alarmLabel
            alarmData.isAgain = switchButtonAgain
            alarmData.repeatDays = repeatDaysString
            
            alarmManager.updateAlarm(targetId: alarmDate, newData: alarmData) {
                self.delegate?.updateAlarm(alarmData)
                self.dismiss(animated: true)
            }
            
        } else {
            alarmManager.saveAlarm(isOn: alarmOnOff, time: alarmDate, label: alarmLabel, isAgain: switchButtonAgain, repeatDays: repeatDaysString) { newAlarm in
                if let newAlarm = newAlarm {
                    self.delegate?.updateAlarm(newAlarm)
                    self.dismiss(animated: true)
                }
            }
        }

        NotificationService.shared.requestAlarmNotification(date: alarmDate, 
                                                            title: "냥이야미",
                                                            subTitle: "오늘도 맛있는 밥을 먹을게요",
                                                            repeatDays: selectedDays.isEmpty ? nil : selectedDays.map { $0.rawValue },
                                                            notificationId: "\(alarmDate)",
                                                            dataIndex: alarmManager.getAlarmList().count == 0 ? nil : alarmManager.getAlarmList().count,
                                                            updateTarget: alarmData?.time)
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
            cell.configure(with: alarmData?.label ?? "")
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SetRepeatAgainTableViewCell.reuseIdentifier, for: indexPath) as? SetRepeatAgainTableViewCell else {
                return UITableViewCell() }
            
            cell.switchDelegate = self
            cell.configure(with: switchAgain)

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
        switchAgain = isOn
    }
}
