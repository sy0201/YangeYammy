//
//  SetRepeatAgainTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 5/13/24.
//

import UIKit
import SnapKit

final class SetRepeatAgainTableViewCell: UITableViewCell, ReuseIdentifying {
    weak var switchDelegate: SwitchValueDelegate?
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = "다시 알림"
        return titleLabel
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
    
    func configure(with isRepeatAgainEnabled: Bool) {
        setSwitchButton.isOn = isRepeatAgainEnabled
    }
}

// MARK: - Private Methods

private extension SetRepeatAgainTableViewCell {
    func setupUI() {
        contentView.addSubviews([titleLabel, setSwitchButton])
    }
    
    func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        setSwitchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        switchDelegate?.switchValueChanged(isOn: sender.isOn)
    }
}
