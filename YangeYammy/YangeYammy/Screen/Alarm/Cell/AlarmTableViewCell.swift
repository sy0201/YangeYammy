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
    var alarmData: AlarmModel? {
        didSet {
            configure()
        }
    }
    
    let meridiemLabel: UILabel = {
        let meridiemLabel = UILabel()
        meridiemLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        meridiemLabel.textColor = .black
        return meridiemLabel
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 40, weight: .light)
        timeLabel.textColor = .black
        return timeLabel
    }()
    
    lazy var setSwitchButton: UISwitch = {
       let switchButton = UISwitch()
        switchButton.isOn = true
        switchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return switchButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal Methods

extension AlarmTableViewCell {
    func configure() {
        meridiemLabel.text = alarmData?.meridiem
        timeLabel.text = alarmData?.time
        setSwitchButton.isOn = ((alarmData?.isOn) != nil)
    }
}

// MARK: - Private Methods

private extension AlarmTableViewCell {
    func setupUI() {
        contentView.addSubviews([meridiemLabel,
                     timeLabel,
                     setSwitchButton])
    }
    
    func setupConstraint() {
        meridiemLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(meridiemLabel.snp.trailing).offset(5)
            make.centerY.equalTo(meridiemLabel.snp.centerY)
        }
        
        setSwitchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(timeLabel.snp.centerY)
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
