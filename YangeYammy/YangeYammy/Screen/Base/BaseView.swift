//
//  BaseView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {}
    func setupConstraint() {}
}
