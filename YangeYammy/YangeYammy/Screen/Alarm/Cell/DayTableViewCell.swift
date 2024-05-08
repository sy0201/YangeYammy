//
//  DayTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit
import SnapKit

final class DayTableViewCell: UITableViewCell, ReuseIdentifying {
    let dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dayLabel.textColor = .black
        return dayLabel
    }()
    
    lazy var selectDayButton: UIButton = {
        let selectDayButton = UIButton()
        selectDayButton.contentHorizontalAlignment = .trailing
        selectDayButton.addTarget(self, action: #selector(selectDateButtonTapped), for: .touchUpInside)
        return selectDayButton
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
    
    func configure(with day: Enum.Day) {
        dayLabel.text = day.rawValue
    }
}

// MARK: - Private Methods

private extension DayTableViewCell {
    func setupUI() {
        contentView.addSubviews([dayLabel,
                                 selectDayButton])
    }
    
    func setupConstraint() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        selectDayButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc func selectDateButtonTapped() {
        if selectDayButton.imageView?.isHidden == false {
            selectDayButton.setImage(nil, for: .normal)
        } else {
            selectDayButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            selectDayButton.tintColor = .systemOrange
        }
    }
}
