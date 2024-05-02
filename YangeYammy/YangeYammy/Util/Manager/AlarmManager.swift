//
//  AlarmManager.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import Foundation

protocol AlarmDelegate: AnyObject {
    func addNewAlarm(_ alarm: AlarmModel)
    func updateAlarm(_ alarm: AlarmModel)
    func reloadAlarmView()
}

final class AlarmManager {
    static let shared = AlarmManager()
    
    private init() {}

    let userDefaults = UserDefaults.standard
    let modelName = "AlarmData"
    
    // UserDefault에서 저장된 알람정보 가져오기
    func getAlarmList() -> [AlarmModel] {
        guard let savedData = userDefaults.data(forKey: modelName),
              let alarms = try? JSONDecoder().decode([AlarmModel].self, from: savedData) else {
            return []
        }
        return alarms
    }
    
    // UserDefault에 알람정보 저장하기
    func saveAlarm(date: Date, isOn: Bool, repeatedDays: [String]) {
        var alarms = getAlarmList()
        let newAlarm = AlarmModel(id: UUID().uuidString, date: date, isOn: isOn, repeatedDays: repeatedDays)
        alarms.append(newAlarm)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alarms), forKey: modelName)

        if let encodedData = try? JSONEncoder().encode(alarms) {
            userDefaults.set(encodedData, forKey: modelName)
        }
    }
    
    // UserDefault에서 알람정보 삭제하기
    func removeAlarm(deleteTarget: AlarmModel) {
        var alarms = getAlarmList()
        alarms.removeAll() { $0.id == deleteTarget.id }
        
        if let encodedData = try? JSONEncoder().encode(alarms) {
            userDefaults.set(encodedData, forKey: modelName)
        }
    }
    
    // UserDefault에 저장된 알람데이터 수정하기
    func updateAlarm(targetId: String, newData: AlarmModel) {
        var alarms = getAlarmList()
        if let index = alarms.firstIndex(where: { $0.id == targetId }) {
            alarms[index] = newData
            
            if let encodedData = try? JSONEncoder().encode(alarms) {
                userDefaults.set(encodedData, forKey: modelName)
            }
        }
    }
}
