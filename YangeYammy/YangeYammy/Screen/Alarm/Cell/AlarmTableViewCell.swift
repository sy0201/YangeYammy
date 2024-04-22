//
//  AlarmTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit
import SnapKit
import UserNotifications

final class AlarmTableViewCell: UITableViewCell, ReuseIdentifying {
    let userNotificationCenter = UNUserNotificationCenter.current()

    private let containerView = UIView()

    let meridiemLabel: UILabel = {
        let meridiemLabel = UILabel()
        meridiemLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        meridiemLabel.textColor = .black
        meridiemLabel.text = "오전"
        return meridiemLabel
    }()
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 40, weight: .light)
        timeLabel.textColor = .black
        timeLabel.text = "00:00"
        return timeLabel
    }()
    
    let setSwitchButton: UISwitch = {
       let switchButton = UISwitch()
        switchButton.isOn = true
        return switchButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension AlarmTableViewCell {
    func setupUI() {
        addSubview(containerView)
        containerView.addSubviews([meridiemLabel,
                                   timeLabel,
                                   setSwitchButton])
        setSwitchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        meridiemLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(meridiemLabel.snp.trailing).offset(0)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        setSwitchButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.centerY.equalTo(containerView.snp.centerY)
        }
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              var alerts = try? PropertyListDecoder().decode([AlarmModel].self, from: data) else { return }
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alarms")
        
        // 알람을 껐다가 다시 켠 경우 추가시
        if sender.isOn {
            userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
}
