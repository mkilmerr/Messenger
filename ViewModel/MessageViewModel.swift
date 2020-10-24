//
//  MessageViewModel.swift
//  Messenger
//
//  Created by Marcos Kilmer on 11/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MessageViewModel {
    weak var messageDelegate:MessageDelegate?
    let friendManager = FriendManager()
    
    var messages = [Message]()
    
    func clearData() {
       let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context =  delegate?.persistentContainer.viewContext {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
               
             let messages = try (context.fetch(fetchRequest)) as? [Message]
                
                for message in messages! {
                    context.delete(message)
                }
                try (context.save())
            }catch {
                
            }
        }
    }
    func setupData() {
        
        clearData()
        
        CoreDataManager.shared.setupCoreDataSingleton()
        
//        CoreDataManager.shared.clearData(type: [Message](), entityName: "Message")
        
      
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: CoreDataManager.shared.selfContext) as! Friend
        
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: CoreDataManager.shared.selfContext) as! Friend
        
        gandhi.name = "Gandhi"
        gandhi.profileImageName = "gandhi"
        
        let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: CoreDataManager.shared.selfContext) as! Friend
        
        hillary.name = "Hillary Clinton"
        hillary.profileImageName = "hillary_profile"
        
        
        self.createMessageWithText(text: "Hello my friends", friend: gandhi, minutesAgo: 2, context: CoreDataManager.shared.selfContext)
        
        self.createMessageWithText(text: "Hello from my FACEBOOK", friend: mark, minutesAgo: 1, context: CoreDataManager.shared.selfContext)
        
     
          self.createMessageWithText(text: "Hello from White House", friend: hillary, minutesAgo: 1, context: CoreDataManager.shared.selfContext)
        
        
        CoreDataManager.shared.saveContext()
        
        
        friendManager.loadMessagesFromFriend()
        
        messages = friendManager.messages
        
//        messages =  CoreDataManager.shared.loadData(entityName: "Message", array: self.messages)

              
//        guard let messagesUnwrapped = messages else {return}
        self.messageDelegate?.setupMessages(messages: messages)
        
    }
    
    
    func createMessageWithText(text:String, friend:Friend, minutesAgo:Double, context: NSManagedObjectContext) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(minutesAgo*60) as Date
        
    }
}
