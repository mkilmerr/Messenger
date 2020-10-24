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
    
    lazy var messageTextView:UITextView = {
       let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
        
    }()
   
    override func setupViews() {
       addSubview(messageTextView)
        
    }
    
    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            messageTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageTextView.heightAnchor.constraint(equalTo: self.heightAnchor),
            messageTextView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setupCell(_ message:Message) {
        messageTextView.text = message.text
    }
}
