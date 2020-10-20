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
    
    
    func fetchFriends() -> [Friend] {
        let fetchRequestFriend = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        do {
            let friends =  (try CoreDataManager.shared.selfContext.fetch(fetchRequestFriend)) as? [Friend]
            if let friends = friends {
                return friends
            }
            
        } catch {
            return []
        }
        
         return []
        
    }
    
    func loadMessagesFromFriend(){
        
        
        for friend in self.fetchFriends() {
            let fetchRequestMessage :NSFetchRequest<Message> = Message.fetchRequest()
            fetchRequestMessage.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            fetchRequestMessage.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
            fetchRequestMessage.fetchLimit = 1
            
            do {
                let fetchMessages = try (CoreDataManager.shared.selfContext.fetch(fetchRequestMessage)) 
                
                for message in fetchMessages {
                    self.messages.append(message)
                }
                //self.messages.append(contentsOf: fetchMessages ?? [])
                
            } catch {

            }
           
            
        }
        
        
        
    }
    
    
}
