//
//  AlarmRepeatDetailView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import UIKit
import SnapKit

final class SelectDayView: BaseView {
    private let containerView = UIView()
    var tableView: UITableView = UITableView()

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
        containerView.addSubview(tableView)
    }
    
    override func setupConstraint() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(40)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.bottom.trailing.equalTo(containerView).offset(-20)
        }
    }
}
