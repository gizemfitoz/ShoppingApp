//
//  AppContainer.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import UIKit
import Service

let app = AppContainer()

final class AppContainer {
    let appCoordinator = AppCoordinator()
    let service = ShoppingService()
}
