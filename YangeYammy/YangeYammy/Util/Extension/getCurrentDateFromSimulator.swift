//
//  getCurrentDateFromSimulator.swift
//  YangeYammy
//
//  Created by siyeon park on 5/6/24.
//

import Foundation

func getCurrentDateFromSimulator(date: Date) -> Date {
    let selectedDate = date
    let timeZone = TimeZone(identifier: "Asia/Seoul")
    let calendar = Calendar.current
    let koreaDate = calendar.date(byAdding: .second, value: TimeZone.current.secondsFromGMT(), to: selectedDate)
    
    return koreaDate!
}
