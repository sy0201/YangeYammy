//
//  AlarmCollectionViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit
import SnapKit

final class AlarmCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlarmCollectionViewCell {
    func setupUI() {
        addSubview(containerView)
        containerView.addSubviews([meridiemLabel,
                                   timeLabel,
                                   setSwitchButton])
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
}
