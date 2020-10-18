//
//  MessageViewModel.swift
//  Messenger
//
//  Created by Marcos Kilmer on 11/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import Foundation
import CoreData

class MessageViewModel {
    weak var messageDelegate:MessageDelegate?
    let friendManageer = FriendManager()
    
    var messages:[Message]?
    
    //    let coreData = CoreDataManager()
    //
    //    let context =
    
    func setupData() {
        
        CoreDataManager.shared.setupCoreDataSingleton()
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: CoreDataManager.shared.selfContext) as! Friend
        
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: CoreDataManager.shared.selfContext) as! Friend
        
        gandhi.name = "Gandhi"
        gandhi.profileImageName = "gandhi"
        
        
        self.createMessageWithText(text: "Hello my friends", friend: gandhi, minutesAgo: 2, context: CoreDataManager.shared.selfContext)
        
        self.createMessageWithText(text: "Hello from my FACEBOOK", friend: mark, minutesAgo: 1, context: CoreDataManager.shared.selfContext)
        
        
        CoreDataManager.shared.saveContext()
        
        
        friendManageer.loadMessagesFromFriend()
        
        messages = friendManageer.messages
        
//        messages =  CoreDataManager.shared.loadData(entityName: "Message", array: self.messages)

//                CoreDataManager.shared.clearData(type: self.messages!, entityName: "Message")
        
        guard let messagesUnwrapped = messages else {return}
        self.messageDelegate?.setupMessages(messages: messagesUnwrapped)
        
    }
    
    
    func createMessageWithText(text:String, friend:Friend, minutesAgo:Double, context: NSManagedObjectContext) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(minutesAgo*60) as Date
        
    }
}
