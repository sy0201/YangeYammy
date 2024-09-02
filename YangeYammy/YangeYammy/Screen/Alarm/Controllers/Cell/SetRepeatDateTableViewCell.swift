//
//  RepeatedDateViewTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit
import SnapKit

final class SetRepeatDateTableViewCell: UITableViewCell, ReuseIdentifying {
    weak var dayDelegate: DayTableViewCellDelegate?
    var selectedDay: Day?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with day: [Day]) {
        if !day.isEmpty {
            let selectedDayStrings = day.map { $0.rawValue }
            dateLabel.text = selectedDayStrings.joined(separator: ", ")
        } else {
            dateLabel.text = "안함"
        }
    }
}

// MARK: - Private Methods

private extension SetRepeatDateTableViewCell {
    func setupUI() {
        contentView.addSubviews([repeatLabel,
                                 dateLabel])
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
    }
}
