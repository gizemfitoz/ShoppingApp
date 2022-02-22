//
//  ProductListContracts.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

protocol ProductListViewModelProtocol {
    var reloadProducts: (() -> ())? { get set }
    func load()
    func numberOfRowsInSection(section: Int) -> Int
}

protocol ProductListViewProtocol {
    var viewModel: ProductListViewModelProtocol! { get set }
}
