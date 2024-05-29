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
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let profileEntityModelName = "ProfileEntity"
    
    // CoreData에 저장된 프로필정보 읽어오기
    func getProfileList() -> [ProfileEntity] {
        var profileData: [ProfileEntity] = []
        guard let context = context else {
            print("getSavedAlarm: context load error")
            return []
        }
        
        let request = NSFetchRequest<ProfileEntity>(entityName: self.profileEntityModelName)
        let descriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [descriptor]
        
        do {
            profileData = try context.fetch(request)
        } catch {
            print("Error fetching profile data: \(error)")
        }
        return profileData
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
        if let profiles = try? context?.fetch(request), let firstProfile = profiles.first {
            return firstProfile
        } else {
            return ProfileEntity(context: context!)
        }
    }
    
    private func saveContext() {
        if ((context?.hasChanges) != nil) {
            do {
                try context!.save()
            } catch {
                print("saveContext: context save error - \(error)")
            }
        }
    }
    
    // CoreData에 프로필정보 저장하기
    func saveProfile(profileImage: String, gender: String, name: String, age: String, weight: Float, kcal: Int, neutrification: String, bcs: Int, completion: @escaping (ProfileEntity?) -> Void) {
        guard let context = context else {
            print("saveProfile: context load error")
            completion(nil)
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: self.profileEntityModelName, in: context) else {
            completion(nil)
            return
        }
        guard let newProfile = NSManagedObject(entity: entity, insertInto: context) as? ProfileEntity else {
            print("saveProfile: entity insert error")
            completion(nil)
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
                completion(newProfile)
            } catch {
                print("saveProfile: context save error")
                completion(nil)
            }
        }
    }
    
    // CoreData에 프로필정보 수정하기
    func updateProfile(profile: ProfileEntity, completion: @escaping () -> Void) {
        guard let context = context else { return }
        
        guard let name = profile.name else {
            print("Profile name is nil")
            return
        }
        
        let request = NSFetchRequest<ProfileEntity>(entityName: self.profileEntityModelName)
        request.predicate = NSPredicate(format: "name = %@", name)

        do {
            if let fetchedProfiles = try context.fetch(request).first {
                fetchedProfiles.profileImage = profile.profileImage
                fetchedProfiles.gender = profile.gender
                fetchedProfiles.name = profile.name
                fetchedProfiles.age = profile.age
                fetchedProfiles.weight = profile.weight
                fetchedProfiles.kcal = profile.kcal
                fetchedProfiles.neutrification = profile.neutrification
                fetchedProfiles.bcs = profile.bcs
            } else {
                let newProfile = ProfileEntity(context: context)
                newProfile.profileImage = profile.profileImage
                newProfile.gender = profile.gender
                newProfile.name = profile.name
                newProfile.age = profile.age
                newProfile.weight = profile.weight
                newProfile.kcal = profile.kcal
                newProfile.neutrification = profile.neutrification
                newProfile.bcs = profile.bcs
            }
            try context.save()
            completion()
        } catch {
            print("Failed to update profile: \(error)")
            completion()
        }
    }
    
    // CoreData에 프로필정보 삭제하기
    func removeProfile(deleteTarget: ProfileEntity, completion: @escaping () -> Void) {
        guard let context = context else {
            print("removeAlarm: context load error")
            completion()
            return
        }
        
        guard let deleteTargetName = deleteTarget.name else {
            completion()
            return
        }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.profileEntityModelName)
        request.predicate = NSPredicate(format: "name == %@", deleteTargetName as CVarArg)
        
        do {
            guard let fetchData = try context.fetch(request) as? [ProfileEntity] else {
                print("removeProfile: fetch error")
                completion()
                return
            }
            
            guard let data = fetchData.first else {
                print("removeProfile: data indexing error")
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
