//
//  UIView.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
