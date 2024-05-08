//
//  RepeatedDateViewTableViewCell.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit
import SnapKit

final class RepeatedDateTableViewCell: UITableViewCell, ReuseIdentifying {
    weak var delegate: RepeatedDateViewCellDelegate?
    
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
    
    let setDateButton: UIButton = {
        let setDateButton = UIButton()
        setDateButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        setDateButton.tintColor = .black
        setDateButton.contentHorizontalAlignment = .trailing
        setDateButton.addTarget(self, action: #selector(setDateButtonTapped), for: .touchUpInside)
        return setDateButton
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
        dateLabel.text = day.rawValue
    }
}

// MARK: - Private Methods

private extension RepeatedDateTableViewCell {
    func setupUI() {
        contentView.addSubviews([repeatLabel,
                     dateLabel,
                     setDateButton])
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
        
        setDateButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc func setDateButtonTapped() {
        delegate?.repeatedDateViewCellDidTapSetDateButton()
    }
}
