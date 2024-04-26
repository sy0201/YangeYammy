//
//  AlarmManager.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import Foundation

final class AlarmManager {
    static let shared = AlarmManager()
    
    private init() {}

    let userDefaults = UserDefaults.standard
    let modelName = "AlarmData"
    
    // 1. UserDefault에서 저장된 알람정보 가져오기
    func getSaveAlarm() -> [AlarmModel] {
        guard let savedData = userDefaults.data(forKey: modelName),
              let alarms = try? JSONDecoder().decode([AlarmModel].self, from: savedData) else {
            return []
        }
        return alarms
    }
    
    // 2. UserDefault에 알람정보 저장하기
    func saveAlarm(date: Date, isOn: Bool, repeatedDays: [String]) {
        var alarms = getSaveAlarm()
        let newAlarm = AlarmModel(id: UUID().uuidString, date: date, isOn: isOn, repeatedDays: repeatedDays)
        alarms.append(newAlarm)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alarms), forKey: modelName)

        if let encodedData = try? JSONEncoder().encode(alarms) {
            userDefaults.set(encodedData, forKey: modelName)
        }
    }
    
    // 3. UserDefault에서 알람정보 삭제하기
    func removeAlarm(deleteTarget: AlarmModel) {
        var alarms = getSaveAlarm()
        alarms.removeAll() { $0.id == deleteTarget.id }
        
        if let encodedData = try? JSONEncoder().encode(alarms) {
            userDefaults.set(encodedData, forKey: modelName)
        }
    }
    
    // 4. UserDefault에 저장된 알람데이터 수정하기
    func updateAlarm(targetId: String, newData: AlarmModel) {
        var alarms = getSaveAlarm()
        if let index = alarms.firstIndex(where: { $0.id == targetId }) {
            alarms[index] = newData
            
            if let encodedData = try? JSONEncoder().encode(alarms) {
                userDefaults.set(encodedData, forKey: modelName)
            }
        }
    }
}
