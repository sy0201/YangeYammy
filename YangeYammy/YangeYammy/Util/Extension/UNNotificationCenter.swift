//
//  UNNotificationCenter.swift
//  YangeYammy
//
//  Created by siyeon park on 4/15/24.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequest(by alert: AlarmModel) {
        let content = UNMutableNotificationContent()
        content.title = "냥이 밥 줄 시간이에요"
        content.body = "오늘도 맛있는 밥을 먹을게요"
        content.sound = .default
        content.badge = 1
        
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
