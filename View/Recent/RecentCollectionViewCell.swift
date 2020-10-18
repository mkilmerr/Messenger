//
//  RecentCollectionViewCell.swift
//  Messenger
//
//  Created by Marcos Kilmer on 09/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit
import Foundation

class RecentCollectionViewCell: BaseCollectionViewCell {
    
    let imageDimension: CGFloat = 64.0
    let hasHeadImageDimension: CGFloat = 20.0
    
    lazy var profileImage: UIImageView = { [unowned self] in
        let obj = UIImageView()
        obj.image = UIImage(named: "steve_profile")
        obj.contentMode = .scaleAspectFit
        obj.layer.cornerRadius = self.imageDimension / 2
        obj.layer.masksToBounds = true
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
        }()
    
    lazy var separatorLine: UIView = {
        let obj = UIView()
        obj.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var friendNameLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Steve Jobs"
        obj.font = UIFont.systemFont(ofSize: 18)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var messageLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Your friend's message and something"
        obj.font = UIFont.systemFont(ofSize: 14)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var friendAndMessageStackView: UIStackView = { [unowned self] in
        let obj = UIStackView(arrangedSubviews: [self.friendNameLabel, self.messageLabel])
        obj.axis = .vertical
        obj.spacing = 8
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
        }()
    
    lazy var timeLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.systemFont(ofSize: 14)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var hasReadMessageImage: UIImageView = { [unowned self] in
        let obj = UIImageView()
        obj.image = UIImage(named: "steve_profile")
        obj.contentMode = .scaleAspectFit
        obj.layer.cornerRadius = self.hasHeadImageDimension / 2
        obj.layer.masksToBounds = true
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
        }()
    
    func setupCell(_ message: Message) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:a"
        
        if let friendName = message.friend?.name, let profileImageName = message.friend?.profileImageName, let messageDate =  message.date {
            
            self.messageLabel.text = message.text
            self.friendNameLabel.text = friendName
            self.profileImage.image = UIImage(named: profileImageName)
             self.timeLabel.text = dateFormatter.string(from: messageDate)
            
        }
        
        
       
    }
    
    override func setupViews() {
        
        addSubview(profileImage)
        addSubview(separatorLine)
        addSubview(friendAndMessageStackView)
        addSubview(timeLabel)
        addSubview(hasReadMessageImage)
        
        
    }
    
    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.profileImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.profileImage.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -40),
            self.profileImage.widthAnchor.constraint(equalToConstant: imageDimension),
            self.profileImage.heightAnchor.constraint(equalToConstant: imageDimension)
        ])
        
        NSLayoutConstraint.activate([
            self.separatorLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.separatorLine.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.009),
            self.separatorLine.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.separatorLine.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            self.friendAndMessageStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.friendAndMessageStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            self.friendAndMessageStackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.friendAndMessageStackView.bottomAnchor.constraint(equalTo: self.profileImage.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.timeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.timeLabel.bottomAnchor.constraint(equalTo: self.friendAndMessageStackView.topAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            self.hasReadMessageImage.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8),
            self.hasReadMessageImage.trailingAnchor.constraint(equalTo: self.timeLabel.trailingAnchor),
            self.hasReadMessageImage.widthAnchor.constraint(equalToConstant: self.hasHeadImageDimension),
            self.hasReadMessageImage.heightAnchor.constraint(equalToConstant: self.hasHeadImageDimension),
            
        ])
        
    }
}
