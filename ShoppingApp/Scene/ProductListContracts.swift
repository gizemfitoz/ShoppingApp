//
//  ProductListContracts.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

protocol ProductListViewModelProtocol {
    var title: String { get }
    var reloadProducts: (() -> ())? { get set }
    var loader: ((Bool) -> ())? { get set }
    var showError: ((String) -> ())? { get set }
    func viewDidLoad()
    func getProducts()
    func searchProducts(with query: String)
    func cancelSearch()
    func numberOfRowsInSection(section: Int) -> Int
    func cellViewModel(at index: Int) -> ProductCellViewModel
}

protocol ProductListViewProtocol {
    var viewModel: ProductListViewModelProtocol! { get set }
}
