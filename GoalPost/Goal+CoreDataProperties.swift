//
//  Goal+CoreDataProperties.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var goalDesc: String?
    @NSManaged public var goalType: String?
    @NSManaged public var goalProgress: Int32
    @NSManaged public var goalCompletionValue: Int32

}
