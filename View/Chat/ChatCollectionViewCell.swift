//
//  ChatCollectionViewCell.swift
//  Messenger
//
//  Created by Marcos Kilmer on 24/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: BaseCollectionViewCell {
    
    static var identifier = "ChatCollectionViewCell"
    
    lazy var profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var messageTextView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
    
    lazy var bubbleView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bubbleImage:UIImage  = {
       let image = UIImage(named:"bubble_gray")
        
        return image!
    }()
    
    override func setupViews() {
        addSubview(profileImage)
        addSubview(bubbleView)
        bubbleView.addSubview(messageTextView)
        
        
    }
    
   
    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 4),
            profileImage.widthAnchor.constraint(equalToConstant:  34),
            profileImage.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
           
            bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 70),
            bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            bubbleView.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            messageTextView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor),
            messageTextView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor),
            messageTextView.heightAnchor.constraint(equalTo: self.bubbleView.heightAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 5),
            messageTextView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -5),
            
        ])
    }
    
    func setupCell(_ message:Message) {
        guard let profile =  message.friend?.profileImageName else {return}
        profileImage.image = UIImage(named: profile)
        messageTextView.text = message.text
        
        
        if message.isSender != false {
            profileImage.isHidden = true
            messageTextView.textColor = .white
            bubbleView.backgroundColor = UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1)

                        
        }
    }
}
