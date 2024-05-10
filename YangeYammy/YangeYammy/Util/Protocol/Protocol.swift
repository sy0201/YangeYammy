//
//  Protocol.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import Foundation

protocol DayTableViewCellDelegate: AnyObject {
    func didSelectDay(_ day: Day)
}
