//
//  MessageDelegate.swift
//  Messenger
//
//  Created by Marcos Kilmer on 12/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import Foundation

protocol MessageDelegate:class {
    func setupMessages(messages:[Message])
}
