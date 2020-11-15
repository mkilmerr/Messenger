//
//  MessageTextUIView.swift
//  Messenger
//
//  Created by Marcos Kilmer on 15/11/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class MessageTextUIView: UIView {
    var keyboardHeight:CGFloat = 0.0
    
    lazy var messageTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter a message"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputAccessoryView = self.sendButtonToolBar
        return textField
    }()
    
    lazy var sendButtonToolBar: UIToolbar = {
       let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
       
    }
    
    @objc func handleKeyboardNotification(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
                
                self.keyboardHeight = isKeyboardShowing ? keyboardFrame.cgRectValue.height : 0
                
            }
           
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(messageTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            messageTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            messageTextField.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
