//
//  BaseCollectionViewCell.swift
//  Messenger
//
//  Created by Marcos Kilmer on 09/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
    func setupConstraints(){}
}
