//
//  AlarmManager.swift
//  YangeYammy
//
//  Created by siyeon park on 4/25/24.
//

import CoreData
import UIKit

protocol AlarmDelegate: AnyObject {
    func updateAlarm()
}

final class AlarmDataManager {
    static let shared = AlarmDataManager()
    
    private init() {}

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    
    let alarmEntityModelName = "AlarmEntity"

    // CoreData에 저장된 알람정보 가져오기
    func getAlarmList() -> [AlarmEntity] {
        var data: [AlarmEntity] = []
        guard let context = context else {
            print("getSavedAlarm: context load error")
            return []
        }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.alarmEntityModelName)
        // 리스트를 time 기준으로 가져오기
        let descriptor = NSSortDescriptor(key: "time", ascending: true)
        
        request.sortDescriptors = [descriptor]
        
        do {
            guard let fetchedAlarmList = try context.fetch(request) as? [AlarmEntity] else {
                return data
            }
            data = fetchedAlarmList
        } catch {
            print("error")
        }
        return data
    }
    
    // CoreData에 알람정보 저장하기
    func saveAlarm(isOn: Bool, time: Date, label: String, isAgain: Bool, repeatDays: String, completion: @escaping () -> Void) {
        guard let context = context else {
            print("saveAlarm: context load error")
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: self.alarmEntityModelName, in: context) else {
            return
        }
        
        guard let newAlarm = NSManagedObject(entity: entity, insertInto: context) as? AlarmEntity else {
            print("saveAlarm: entity insert error")
            return
        }
        
        newAlarm.isOn = isOn
        newAlarm.time = time
        newAlarm.label = label
        newAlarm.isAgain = isAgain
        newAlarm.repeatDays = repeatDays
        print("repeatDaysString \(repeatDays)")
        if context.hasChanges {
            do {
                try context.save()
                completion()
            } catch {
                print("saveAlarm: context save error")
                completion()
            }
        }
    }
    
    // CoreData에 알람정보 삭제하기
    func removeAlarm(deleteTarget: AlarmEntity, completion: @escaping () -> Void) {
        guard let context = context else {
            print("removeAlarm: context load error")
            completion()
            return
        }
        guard let targetId = deleteTarget.time else {
            print("removeAlarm: remove target id error")
            completion()
            return
        }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.alarmEntityModelName)
        request.predicate = NSPredicate(format: "time = %@", targetId as CVarArg)
        
        do {
            guard let fetchData = try context.fetch(request) as? [AlarmEntity] else {
                print("removeAlarm: fetch error")
                completion()
                return
            }
            
            guard let data = fetchData.first else {
                print("removeAlarm: data indexing error")
                completion()
                return
            }
            context.delete(data)
            
            do {
                try context.save()
                completion()
                
            } catch {
                print("removeAlarm: context save error")
                completion()
            }
        } catch {
            print("removeAlarm: some error")
        }
    }
    
    // CoreData에 알람정보 업데이트하기
    func updateAlarm(targetId: Date, newData: AlarmEntity, completion: @escaping () -> Void) {
        guard let context = context else {
            print("removeAlarm: context load error")
            completion()
            return
        }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.alarmEntityModelName)
        request.predicate = NSPredicate(format: "time = %@", targetId as CVarArg)
        
        do {
            guard let fetchedAlarms = try context.fetch(request) as? [AlarmEntity] else {
                print("updateAlarm: fetch error")
                completion()
                return
            }
            
            guard let targetAlarm = fetchedAlarms.first else {
                print("updateAlarm: indexing error")
                completion()
                return
            }
            
            targetAlarm.isOn = newData.isOn
            targetAlarm.time = newData.time
            targetAlarm.label = newData.label
            targetAlarm.isAgain = newData.isAgain
            targetAlarm.repeatDays = newData.repeatDays
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("updateAlarm: context save error")
                }
            }
            completion()
        } catch {
            print("updateAlarm: error")
            completion()
        }
    }
}
