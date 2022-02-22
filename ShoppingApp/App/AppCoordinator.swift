//
//  AppCoordinator.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    private var window : UIWindow?
    
    init(window : UIWindow) {
        self.window = window
    }
    
    @discardableResult
    func start() -> UIViewController {
        let viewController = ProductListCoordinator().start()
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        return viewController
    }
}
