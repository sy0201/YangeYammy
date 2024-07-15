//
//  DayTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit
import SnapKit

final class DayTableViewCell: UITableViewCell, ReuseIdentifying {
    weak var delegate: DayTableViewCellDelegate?

    var isSelectDay: Bool = false {
        didSet {
            self.changeState()
        }
    }
    
    let dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dayLabel.textColor = .black
        return dayLabel
    }()
    
    let selectImg: UIImageView = {
        let selectImg = UIImageView()
        selectImg.image = UIImage(systemName: "checkmark")
        selectImg.tintColor = UIColor(red: 93/255, green: 176/255, blue: 117/255, alpha: 1.0)
        selectImg.bounds.size.height = 24
        return selectImg
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
    
    func configure(with day: Day, isSelected: Bool) {
        dayLabel.text = day.rawValue
        isSelectDay = isSelected
    }
}

// MARK: - Private Methods

private extension DayTableViewCell {
    func setupUI() {
        contentView.addSubviews([dayLabel, selectImg])
    }
    
    func setupConstraint() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        selectImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func changeState() {
        selectImg.image = isSelectDay ? UIImage(systemName: "checkmark") : nil
    }
}
