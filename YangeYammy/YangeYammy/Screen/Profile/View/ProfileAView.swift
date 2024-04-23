//
//  ProfileAView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/22/24.
//

import UIKit
import SnapKit

final class ProfileAView: BaseView {

    private let containerView = UIView()
    var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.locale = Locale(identifier: "ko")
        return datePickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        containerView.backgroundColor = .white
        addSubview(containerView)
        containerView.addSubview(datePickerView)
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        datePickerView.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView).offset(10)
            make.trailing.equalTo(containerView).offset(-10)
            make.height.equalTo(50)
        }
    }
}

