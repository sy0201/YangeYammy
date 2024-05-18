//
//  ProfileDataManager.swift
//  YangeYammy
//
//  Created by siyeon park on 5/17/24.
//

import Foundation
import UIKit
import CoreData

final class ProfileDataManager {
    static let shared = ProfileDataManager()
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to get AppDelegate")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    let context: NSManagedObjectContext
    let profileEntityModelName = "ProfileEntity"
    
    // CoreData에 저장된 프로필정보 가져오기
    func getProfile() -> [ProfileEntity] {
        var data: [ProfileEntity] = []
//        guard let context = context else {
//            print("getSavedProfile: context load error")
//            return []
//        }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.profileEntityModelName)
        // 리스트를 name 기준으로 가져오기
        let descriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [descriptor]
        
        do {
            guard let fetchedProfileList = try context.fetch(request) as? [ProfileEntity] else {
                return data
            }
            data = fetchedProfileList
        } catch {
            print("error")
        }
        return data
    }
    
    func saveProfileDetail(name: String) {
        let profile = fetchProfile()
        profile.name = name
        saveContext()
    }
    
    func saveProfileDetail(age: String) {
        let profile = fetchProfile()
        profile.age = age
        saveContext()
    }
    
    func saveProfileDetail(weight: Float) {
        let profile = fetchProfile()
        profile.weight = weight
        saveContext()
    }
    
    func saveProfileDetail(kcal: Int) {
        let profile = fetchProfile()
        profile.kcal = Int16(kcal)
        saveContext()
    }
    
    private func fetchProfile() -> ProfileEntity {
        let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        let profiles = try? context.fetch(request)
        return profiles?.first ?? ProfileEntity(context: context)
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("saveContext: context save error - \(error)")
            }
        }
    }
    
    
    // CoreData에 알람정보 저장하기
    func saveProfile(profileImage: String, gender: String, name: String, age: String, weight: Float, kcal: Int, neutrification: String, bcs: Int, completion: @escaping () -> Void) {
//        guard let context = context else {
//            print("saveProfile: context load error")
//            return
//        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: self.profileEntityModelName, in: context) else {
            return
        }
        
        guard let newProfile = NSManagedObject(entity: entity, insertInto: context) as? ProfileEntity else {
            print("saveAlarm: entity insert error")
            return
        }
        
        newProfile.profileImage = profileImage
        newProfile.gender = gender
        newProfile.name = name
        newProfile.age = age
        newProfile.weight = weight
        newProfile.kcal = Int16(kcal)
        newProfile.neutrification = neutrification
        newProfile.bcs = Int16(bcs)
        
        if context.hasChanges {
            do {
                try context.save()
                completion()
            } catch {
                print("saveProfile: context save error")
                completion()
            }
        }
    }
    
    // CoreData에 프로필정보 삭제하기
    func removeProfile(deleteTarget: ProfileEntity, completion: @escaping () -> Void) {
//        guard let context = context else {
//            print("removeProfile: context load error")
//            completion()
//            return
//        }
        guard let targetId = deleteTarget.name else {
            print("removeProfile: remove target id error")
            completion()
            return
        }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.profileEntityModelName)
        
        do {
            guard let fetchData = try context.fetch(request) as? [ProfileEntity] else {
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
                print("removeProfile: context save error")
                completion()
            }
        } catch {
            print("removeProfile: some error")
        }
    }
}
