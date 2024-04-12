//
//  ReuseIdentifying.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

protocol ReuseIdentifying: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
