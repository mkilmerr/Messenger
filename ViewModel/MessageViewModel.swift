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
        
        self.createMessageWithText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", friend: mark, minutesAgo: 4, context: CoreDataManager.shared.selfContext)
        
     
          self.createMessageWithText(text: "Hello from White House", friend: hillary, minutesAgo: 1, context: CoreDataManager.shared.selfContext)
        

        self.createMessageWithText(text: "Hello hell", friend: hillary, minutesAgo: 1, context: CoreDataManager.shared.selfContext)
        
         self.createMessageWithText(text: "Sender message", friend: hillary, minutesAgo: 1, context: CoreDataManager.shared.selfContext,isSender: true)
        
        
        CoreDataManager.shared.saveContext()
        
        
        friendManager.loadMessagesFromFriend()
        
        messages = friendManager.messages
        
//        messages =  CoreDataManager.shared.loadData(entityName: "Message", array: self.messages)

              
//        guard let messagesUnwrapped = messages else {return}
        self.messageDelegate?.setupMessages(messages: messages)
        
    }
    
    
    func createMessageWithText(text:String, friend:Friend, minutesAgo:Double, context: NSManagedObjectContext, isSender:Bool = false ) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(minutesAgo*60) as Date
        message.isSender = NSNumber(booleanLiteral: isSender)
        
    }
}
