//
//  Enum.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import Foundation

enum Day: String, CaseIterable {
    case sunday = "일요일 마다"
    case monday = "월요일 마다"
    case tuesday = "화요일 마다"
    case wednesday = "수요일 마다"
    case thursday = "목요일 마다"
    case friday = "금요일 마다"
    case saturday = "토요일 마다"
    case none = "안함"
}

enum Gender: String {
    case male = "남아"
    case female = "여아"
}

enum Neutrification: String {
    case yes = "중성화후"
    case no = "중성화전"
}

enum BcsType: Int {
    case bcs1 = 1
    case bcs2 = 2
    case bcs3 = 3
    case bcs4 = 4
    case bcs5 = 5
}
