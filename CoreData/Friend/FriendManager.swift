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
    var friendNames = [String]()
    
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
    
   class  func loadMessagesFromFriend(friend:Friend) -> [Message] {
        
            let fetchRequestMessage :NSFetchRequest<Message> = Message.fetchRequest()
            fetchRequestMessage.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
            fetchRequestMessage.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
            
            
            do {
                let fetchMessages = try (CoreDataManager.shared.selfContext.fetch(fetchRequestMessage))
                return fetchMessages
                
            } catch {
                print(error)
            }
            
        
        
        return [Message]()
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
                CoreDataManager.shared.saveContext()
            } catch {

            }
           
            
        }
        
        self.messages = filterMessages(messages)
        
    }
    func filterMessages(_ messages: [Message]) -> [Message] {
        
        var arrayOfFilterMessages = [Message]()
        
        messages.forEach { (message) in
            
            friendNames.append((message.friend?.name)!)
        }
        
        
        let objectSet = Set(friendNames.map { $0 })
        
        let array = Array(objectSet)
        
        array.forEach { (friend) in
            let index = messages.lastIndex{$0.friend?.name == friend}
            arrayOfFilterMessages.append(messages[index!])
        }
        
        return arrayOfFilterMessages
        
        
    }
    
    
}
