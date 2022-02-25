//
//  ProductListCoordinator.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import UIKit

final class ProductListCoordinator: Coordinator {
    func start() -> UIViewController {
        let viewController = UIStoryboard(name: "ProductList", bundle: .main)
            .instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        viewController.viewModel = ProductListViewModel(service: app.service)
        return viewController
    }
}
