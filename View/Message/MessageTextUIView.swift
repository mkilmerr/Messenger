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
        textField.placeholder = "Type a Message"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
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
                print(isKeyboardShowing)
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
        
    }
}
