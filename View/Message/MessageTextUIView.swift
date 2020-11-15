//
//  MessageTextUIView.swift
//  Messenger
//
//  Created by Marcos Kilmer on 15/11/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class MessageTextUIView: UIView {
    lazy var messageTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Type a Message"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(messageTextField)
    }
    
    func setupConstraints() {
        
    }
}
