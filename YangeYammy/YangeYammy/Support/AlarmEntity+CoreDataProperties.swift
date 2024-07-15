//
//  AlarmEntity+CoreDataProperties.swift
//  YangeYammy
//
//  Created by siyeon park on 6/3/24.
//
//

import Foundation
import CoreData


extension AlarmEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmEntity> {
        return NSFetchRequest<AlarmEntity>(entityName: "AlarmEntity")
    }

    @NSManaged public var isAgain: Bool
    @NSManaged public var isOn: Bool
    @NSManaged public var label: String?
    @NSManaged public var repeatDays: String?
    @NSManaged public var time: Date?

}

extension AlarmEntity : Identifiable {

}
