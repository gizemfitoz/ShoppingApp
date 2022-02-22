//
//  ProductListCoordinator.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import UIKit

final class ProductListCoordinator: Coordinator {
    var rootViewController: UINavigationController!

    func start() -> UIViewController {
        let viewController = UIStoryboard(name: "ProductList", bundle: .main)
            .instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        rootViewController = UINavigationController(rootViewController: viewController)
        viewController.viewModel = ProductListViewModel()
        return viewController
    }
}
