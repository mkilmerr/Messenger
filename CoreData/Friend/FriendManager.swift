//
//  FriendManager.swift
//  Messenger
//
//  Created by Marcos Kilmer on 18/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import Foundation
import CoreData

class FriendManager {
    var messages = [Message]()
    
    func loadMessagesFromFriend(){
        let fetchRequestFriend = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        
        
        do {
            let friends =  (try CoreDataManager.shared.selfContext.fetch(fetchRequestFriend)) as? [Friend]
            
           try  friends?.forEach({ (friend) in
            
                let fetchRequestMessage = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                fetchRequestMessage.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchRequestMessage.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequestMessage.fetchLimit = 1
                
                
                let fetchMessages = try (CoreDataManager.shared.selfContext.fetch(fetchRequestMessage)) as? [Message]
                
            self.messages.append(contentsOf: fetchMessages ?? [])

                
            })
            
        } catch let err {
            print(err)
        }
    }
}
