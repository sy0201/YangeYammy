//
//  SetLabelTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 5/13/24.
//

import UIKit
import SnapKit

final class SetLabelTableViewCell: UITableViewCell, ReuseIdentifying {
    weak var delegate: LabelTableViewCellDelegate?
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = "레이블"
        return titleLabel
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        
        let attributedPlaceholder = NSAttributedString(
            string: "알람",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1.0),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
            ]
        )
        textField.attributedPlaceholder = attributedPlaceholder
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
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
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(text: textField.text)
    }
}

// MARK: - Private Methods

private extension SetLabelTableViewCell {
    func setupUI() {
        contentView.addSubviews([titleLabel, textField])
    }
    
    func setupConstraint() {
        titleLabel.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        textField.setContentHuggingPriority(.init(rawValue: 748), for: .horizontal)
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}
