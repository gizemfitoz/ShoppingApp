//
//  ProductListViewModelSpy.swift
//  ShoppingAppTests
//
//  Created by Gizem Fitoz on 25.02.2022.
//

@testable import ShoppingApp

final class ProductListViewModelSpy: ProductListViewModelProtocol {
    var title = "ProductsSpyTitle"
    
    var reloadProducts: (() -> ())?
    
    var loader: ((Bool) -> ())?
    
    var showError: ((String) -> ())?
    
    var viewDidLoadCalled = false
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    var getProductsCalled = false
    func getProducts() {
        getProductsCalled = true
    }
    
    
    var searchProductsCalled = false
    func searchProducts(with query: String) {
        searchProductsCalled = true
    }
    
    var cancelSearchCalled = false
    func cancelSearch() {
        cancelSearchCalled = true
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 2
    }
    
    var testWithProductHasNextDayDelivery = false
    func cellViewModel(at index: Int) -> ProductCellViewModel {
        return ProductCellViewModel(
            productName: "name",
            salesPrice: "1",
            nextDayDelivery: testWithProductHasNextDayDelivery,
            productImageUrl: nil
        )
    }
}
