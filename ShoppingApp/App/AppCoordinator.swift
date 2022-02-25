//
//  AppCoordinator.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    let rootViewController = UINavigationController()

    @discardableResult
    func start() -> UIViewController {
        return ProductListCoordinator().start()
    }
}
