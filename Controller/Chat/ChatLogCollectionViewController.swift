//
//  ChatLogCollectionViewController.swift
//  Messenger
//
//  Created by Marcos Kilmer on 24/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class ChatCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = FriendManager.loadMessagesFromFriend(friend: friend!)
            
        }
    }
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .white
        self.collectionView!.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: ChatCollectionViewCell.identifier)

     
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
       return self.messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.identifier, for: indexPath) as! ChatCollectionViewCell
        
    
        cell.setupCell(self.messages[indexPath.row])
        
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageText = self.messages[indexPath.row].text {
            let size  = CGSize(width: view.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: nil, context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + (estimatedFrame.height * 0.7))
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 85
    }

  

}
