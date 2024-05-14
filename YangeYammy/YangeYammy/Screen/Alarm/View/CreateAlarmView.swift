//
//  CreateAlarmView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit
import SnapKit

final class CreateAlarmView: BaseView {
    private let containerView = UIView()
    var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePickerView.datePickerMode = .time
        datePickerView.locale = Locale(identifier: "ko")
        datePickerView.minuteInterval = 1
        return datePickerView
    }()
    
    var tableView: UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        //viewTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        containerView.backgroundColor = .white
        addSubview(containerView)
        containerView.addSubviews([datePickerView,
                                   tableView])
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        datePickerView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(56)
            make.leading.equalTo(containerView).offset(10)
            make.trailing.equalTo(containerView).offset(-10)
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(datePickerView.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).offset(-20)
            make.bottom.equalTo(containerView).offset(-20)
        }
    }
}
