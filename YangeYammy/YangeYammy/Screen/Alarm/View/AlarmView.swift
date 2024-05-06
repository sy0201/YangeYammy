//
//  AlarmView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit
import SnapKit
import UserNotifications

final class AlarmView: BaseView {
    var alarmManager = AlarmManager.shared
    let userNotificationCenter = UNUserNotificationCenter.current()

    private let containerView = UIView()
    lazy var tableView: UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        addSubview(containerView)
        containerView.addSubview(tableView)
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
}

// MARK: - Private Methods

private extension AlarmView {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewController Protocol

extension AlarmView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarmManager.getAlarmList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.reuseIdentifier, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell() }
        let alarmList = alarmManager.getAlarmList()
        let alarm = alarmList[indexPath.row]

        cell.alarmData = alarm
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
            alarmManager.removeAlarm(deletaTarget: removeAlarm) {
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
