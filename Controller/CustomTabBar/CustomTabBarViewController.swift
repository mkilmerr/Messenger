//
//  CustomTabBarViewController.swift
//  Messenger
//
//  Created by Marcos Kilmer on 24/10/20.
//  Copyright © 2020 mkilmer. All rights reserved.
//

import UIKit
import Foundation

class CustomTabBarViewController: UITabBarController {
    let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
               
        let recentViewController = createTabBarItems(viewController: RecentCollectionViewController(collectionViewLayout:flowLayout), name: "Recent", imageName: "recent")
        
        viewControllers = [
            recentViewController
            
        ]
    }
}

extension CustomTabBarViewController {
    
    func createTabBarItems(viewController:UIViewController,name:String, imageName:String) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        
        navigationController.navigationItem.title = name
        navigationController.tabBarItem.title = name
        navigationController.tabBarItem.image = UIImage(named: imageName)
        navigationController.view.backgroundColor = .white
        
        return navigationController
        
    }
}
