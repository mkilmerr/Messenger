//
//  RecentCollectionViewController.swift
//  Messenger
//
//  Created by Marcos Kilmer on 09/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit

class RecentCollectionViewController: UICollectionViewController {
 

    let messageViewModel = MessageViewModel()
    var messages = [Message]()
    let cellIdentifier = "RecentCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        self.messageViewModel.messageDelegate = self
        self.messageViewModel.setupData()
        
        self.configureCollectionView()
     
       
    }
    
    
}

extension RecentCollectionViewController: MessageDelegate {
    func setupMessages(messages: [Message]) {
        self.messages = messages
    }
    
}

extension RecentCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func configureCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        self.collectionView!.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? RecentCollectionViewCell {
            
            cell.setupCell(self.messages[indexPath.row])
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flowLayout = UICollectionViewFlowLayout()
        
        let chatCollectionViewController = ChatCollectionViewController(collectionViewLayout: flowLayout)
        chatCollectionViewController.friend = self.messages[indexPath.row].friend
        
        self.navigationController?.pushViewController(chatCollectionViewController, animated: true)
        
    }
    
}
