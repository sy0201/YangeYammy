//
//  NotificationService.swift
//  YangeYammy
//
//  Created by siyeon park on 5/6/24.
//

import Foundation
import UserNotifications
import UIKit

final class NotificationService: NSObject {
    static let shared = NotificationService()
    
    private override init() {}
    
    let UNCurrentCenter = UNUserNotificationCenter.current()
    
    var pendingNotificationArray: [UNNotificationRequest]?
    
    let alarmManager = AlarmDataManager.shared
    
    var reloadTable: UITableView?
    
    func authorizeNotification() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNCurrentCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No UNAuthorize error")
            
            guard granted else {
                print("사용자가 알람 권한을 허용하지 않았습니다.")
                return
            }
            
            self.UNCurrentCenter.delegate = self
        }
    }
    
    func requestAlarmNotification(date: Date?, title: String, subTitle: String, repeatDays: [String]?, notificationId: String, dataIndex: Int?, updateTarget: Date?) {
        guard let alarm = alarmManager.getAlarmList().first(where: { $0.time == date }), alarm.isOn else {
            print("Alarm has been deleted or is off. Notification not scheduled.")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.categoryIdentifier = "Alarm"
        content.sound = .default

        var trigger: UNCalendarNotificationTrigger
        
        if let repeatDays = repeatDays, !repeatDays.isEmpty {
            // Schedule notifications for specific days
            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
            for day in repeatDays {
                if let weekday = Day(rawValue: day)?.weekdayValue {
                    dateComponents.weekday = weekday
                    trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    
                    let request = UNNotificationRequest(identifier: notificationId + day, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
            }
        } else {
            // Schedule daily notifications
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    func getTrigger(date: Date?, notificationId: String, _ dataIndex: Int?, updateTarget: Date?) -> UNNotificationTrigger? {
        var date = date!
        
        var dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)

        if #available(iOS 15, *) {
            let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: Date.now)
            
            if (currentDateComponents.day! > dateComponents.day! || currentDateComponents.hour! > dateComponents.hour! || (currentDateComponents.hour! == dateComponents.hour && currentDateComponents.minute! > dateComponents.minute!)) {
                
                date = Calendar.current.date(byAdding: .hour, value: 24, to: date)!
                
                dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: getCurrentDateFromSimulator(date: date))
                
                let _ = alarmManager.getAlarmList().map { data in
                    let newData = data
                    
                    if updateTarget == data.time {
                        newData.time = date
                        
                        alarmManager.updateAlarm(targetId: updateTarget!, newData: newData) {
                            print("time updated!")
                        }
                    }
                }
                UNCurrentCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
            }
        } else {
            // Fallback on earlier versions
        }
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    }
    
    func setCustomAction(actionIdentifier: String, actionTitle: String, categoryIdentifier: String){
        let customAction = UNNotificationAction(identifier: actionIdentifier, title: actionTitle, options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [customAction], intentIdentifiers: [])
        
        self.UNCurrentCenter.setNotificationCategories([category])
    }
    
    func removeNotification(withIdentifier identifier: String, repeatDays: [String]?) {
        if let repeatDays = repeatDays, !repeatDays.isEmpty {
            // 요일별로 개별적으로 삭제
            for day in repeatDays {
                let dayIdentifier = identifier
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dayIdentifier])
                print("요일알람 삭제 id \(dayIdentifier)")
            }
        } else {
            // 매일 반복되는 알람 삭제
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            print("반복알람 삭제 id \(identifier)")
        }
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.actionIdentifier)
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("dismiss")
        case UNNotificationDefaultActionIdentifier:
            print("default")
        case "dismiss":
            print("custom")
        default:
            break
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.content.userInfo["updateTarget"] as! Int != -1 {
            let alarmDataList = alarmManager.getAlarmList()
            alarmDataList[notification.request.content.userInfo["updateTarget"] as! Int - 1].isOn = false
        }
        
        if let reloadTable {
            reloadTable.reloadData()
        }
        
        if #available(iOS 14.0, *) {
            let options: UNNotificationPresentationOptions = [.banner, .sound]
            completionHandler(options)
        } else {
            // Fallback on earlier versions
        }
    }
}
