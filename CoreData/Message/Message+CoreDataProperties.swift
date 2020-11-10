//
//  Message+CoreDataProperties.swift
//  Messenger
//
//  Created by Marcos Kilmer on 18/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var isSender: NSNumber?
    @NSManaged public var friend: Friend?

}
