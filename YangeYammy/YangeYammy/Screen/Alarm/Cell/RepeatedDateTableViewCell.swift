//
//  RepeatedDateViewTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit
import SnapKit

final class RepeatedDateTableViewCell: UITableViewCell, ReuseIdentifying {
    weak var delegate: PresentVCDelegate?
    
    let repeatLabel: UILabel = {
        let repeatLabel = UILabel()
        repeatLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        repeatLabel.textColor = .black
        repeatLabel.text = "반복"
        return repeatLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = .black
        return dateLabel
    }()
    
    let setRepeatDayButton: UIButton = {
        let setRepeatDayButton = UIButton()
        setRepeatDayButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        setRepeatDayButton.tintColor = .black
        setRepeatDayButton.contentHorizontalAlignment = .trailing
        setRepeatDayButton.addTarget(self, action: #selector(setRepeatDayButtonTapped), for: .touchUpInside)
        return setRepeatDayButton
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
    
    func setupActions() {
        setRepeatDayButton.addTarget(self, action: #selector(setRepeatDayButtonTapped), for: .touchUpInside)
    }
    
    @objc func setRepeatDayButtonTapped() {
        delegate?.presentViewController()
    }
    
    func configure(with day: Enum.Day) {
        dateLabel.text = day.rawValue
    }
}

// MARK: - Private Methods

private extension RepeatedDateTableViewCell {
    func setupUI() {
        contentView.addSubviews([repeatLabel,
                                 dateLabel,
                                 setRepeatDayButton])
    }
    
    func setupConstraint() {
        repeatLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        setRepeatDayButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
