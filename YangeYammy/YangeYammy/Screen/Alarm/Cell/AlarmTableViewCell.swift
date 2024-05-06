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
    var alarmData: AlarmEntity? {
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
        guard let alarmData = alarmData else {
            return
        }
        
        guard let time = alarmData.time else {
            return
        }
        timeLabel.text = "\(setupTimeString(time: time).0)"
    
        meridiemLabel.text = setupTimeString(time: time).1
        setSwitchButton.isOn = alarmData.isOn
    }
    
    func setupTimeString(time: Date) -> (String, String){
        var isNoon = false
        
        // 코어데이터에 저장된 UTC를 KST로 변환하는 로직
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        
        // timeString 반환 로직
        var timeString = dateFormatter.string(from: time)
        
        if(timeString.first == "0"){
            timeString.remove(at: timeString.startIndex)
        }
        
        var timeArray = timeString.split(separator: ":").map { str in
            String(str)
        }
        
        if(Int(timeArray[0])! > 12){
            timeArray[0] = String(Int(timeArray[0])! - 12)
            isNoon = true
        }
        
        return (timeArray.joined(separator: ":"), isNoon ? "오후" : "오전")
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
    }
}
