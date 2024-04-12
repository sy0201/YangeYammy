//
//  AlarmModel.swift
//  YangeYammy
//
//  Created by siyeon park on 4/12/24.
//

import Foundation

struct AlarmModel: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time: String {
        let timeFormmatter = DateFormatter()
        timeFormmatter.dateFormat = "hh:mm"
        return timeFormmatter.string(from: date)
    }
    
    var meridiem: String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a"
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
