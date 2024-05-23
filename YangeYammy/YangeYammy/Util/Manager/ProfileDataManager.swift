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
    func getProfileList() -> [ProfileEntity] {
        var data: [ProfileEntity] = []

        let request = NSFetchRequest<ProfileEntity>(entityName: self.profileEntityModelName)
        let descriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [descriptor]
        
        do {
            data = try context.fetch(request)
        } catch {
            print("Error fetching profile data: \(error)")
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
        if let profiles = try? context.fetch(request), let firstProfile = profiles.first {
            return firstProfile
        } else {
            return ProfileEntity(context: context)
        }
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
    func saveProfile(profileImage: String?, gender: String?, name: String?, age: String?, weight: Float?, kcal: Int?, neutrification: String?, bcs: Int?, completion: @escaping () -> Void) {
        //let context = self.context
        guard let entity = NSEntityDescription.entity(forEntityName: self.profileEntityModelName, in: context) else {
            return
        }
        
        let newProfile = ProfileEntity(entity: entity, insertInto: context)
        newProfile.id = UUID()
        newProfile.profileImage = profileImage
        newProfile.gender = gender
        newProfile.name = name
        newProfile.age = age
        newProfile.weight = weight ?? 0.0
        newProfile.kcal = Int16(kcal ?? 0)
        newProfile.neutrification = neutrification
        newProfile.bcs = Int16(bcs ?? 0)
        
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
    
    func updateProfile(profile: ProfileEntity, completion: @escaping () -> Void) {
        guard let profileId = profile.id else {
            print("Profile ID is nil")
            return
        }
        
        let request: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", profileId as CVarArg)

        do {
            let results = try context.fetch(request)
            if let existingProfile = results.first {
                existingProfile.name = profile.name
                existingProfile.age = profile.age
                existingProfile.gender = profile.gender
                existingProfile.weight = profile.weight
                existingProfile.kcal = profile.kcal
                existingProfile.neutrification = profile.neutrification
                existingProfile.bcs = profile.bcs
                
                try context.save()
            } else {
                print("Profile not found")
            }
        } catch {
            print("Failed to update profile: \(error)")
        }
    }
    
    // CoreData에 프로필정보 삭제하기
    func removeProfile(deleteTarget: ProfileEntity, completion: @escaping () -> Void) {

        guard let deleteTargetId = deleteTarget.id else {
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
