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
    var alarmList: [AlarmModel] = []
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
        alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.reuseIdentifier, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setSwitchButton.tag = indexPath.row
        let alarm = alarmList[indexPath.row]
        cell.configure(with: alarm)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let deletedAlarm = alarmList.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alarmList), forKey: "alarms")
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [deletedAlarm.id])
            
            // tableView.reloadData()를 호출하기 전에 테이블 뷰에서 해당 셀을 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
