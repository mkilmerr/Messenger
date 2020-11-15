//
//  ChatLogCollectionViewController.swift
//  Messenger
//
//  Created by Marcos Kilmer on 24/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class ChatCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    let messageViewModel = MessageViewModel()
    
    lazy var sendButton: UIBarButtonItem = {
        let sendButton = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(sendButtonDidTapped))
        return sendButton
    }()
    
    var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    var bottomContraints:NSLayoutConstraint?
    
    let messageTextView = MessageTextUIView()
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
        self.messageTextView.messageTextField.delegate = self
        self.collectionView!.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: ChatCollectionViewCell.identifier)
        
        setupMessageTextUIView()
        self.messageTextView.sendButtonToolBar.setItems([self.flexibleSpaceButton,self.sendButton], animated: false)
        self.messageTextView.messageTextField.addTarget(self, action: #selector(messageTextFieldDidTapped), for: .allEvents)
        
        
    }
    
    @objc func messageTextFieldDidTapped() {
        bottomContraints = NSLayoutConstraint(item: self.messageTextView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -self.messageTextView.keyboardHeight)
           self.view.addConstraint(bottomContraints!)
        
        let indexPath = NSIndexPath(item: self.messages.count, section: 0)
        self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
        
        self.collectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    func setupMessageTextUIView() {
        view.addSubview(messageTextView)
        NSLayoutConstraint.activate([
         messageTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
         messageTextView.heightAnchor.constraint(equalToConstant: 40),
         messageTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       
    }
    
    @objc func sendButtonDidTapped() {
        if let message = self.messageTextView.messageTextField.text, let friend = self.messages[0].friend {
            if !message.isEmpty {
                let newMessage = self.messageViewModel.createMessageWithTextWithReturn(text: message, friend: friend, minutesAgo: 1, context: CoreDataManager.shared.selfContext, isSender: true)
                self.messages.append(newMessage)
                self.messageTextView.messageTextField.text?.removeAll()
                self.collectionView.reloadData()
                self.messageTextView.removeFromSuperview()
                setupMessageTextUIView()
            }
        }
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

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
      
        self.messageTextView.messageTextField.endEditing(true)
        self.messageTextView.removeFromSuperview()
        setupMessageTextUIView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.messageTextView.removeFromSuperview()
        setupMessageTextUIView()
        return true
    }

}
