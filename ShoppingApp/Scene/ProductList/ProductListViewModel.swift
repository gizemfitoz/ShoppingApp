//
//  ProductListViewModel.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import Service

final class ProductListViewModel: ProductListViewModelProtocol {
    var reloadProducts: (() -> ())?
    var loader: ((Bool) -> ())?
    var showError: ((String) -> ())?
    var title = "Products"
    private let service: ShoppingServiceProtocol
    private var products: [SearchResponse.Product] = []
    private var isPaginating = false
    private var nextPage = 1
    private var totalPages = 1
    private var searchQuery = "" {
        didSet {
            nextPage = 1
        }
    }

    init(service: ShoppingServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        getProducts()
    }
    
    func getProducts() {
        if isPaginating || self.nextPage > totalPages {
            return
        }
        
        isPaginating = true

        loader?(true)
        service.searchProducts(with: searchQuery, page: nextPage) { [weak self] result in
            guard let self = self else { return }
            self.loader?(false)
            
            self.isPaginating = false
            
            switch result {
            case let .success(response):
                self.totalPages = response.pageCount
                self.nextPage = response.currentPage + 1
                self.products.append(contentsOf: response.products)
                self.reloadProducts?()
                
            case let .failure(error):
                self.showError?(error.localizedDescription)
                print("🔥 Error occurred: \(error)")
            }
        }
    }
    
    func searchProducts(with query: String) {
        if query == searchQuery { return }
        clearValues()
        searchQuery = query
        getProducts()
    }
    
    func cancelSearch() {
        clearValues()
        getProducts()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        products.count
    }
    
    func cellViewModel(at index: Int) -> ProductCellViewModel {
        let product = products[index]
        return ProductCellViewModel(
            productName: product.name,
            salesPrice: "Price: \(product.salesPrice)",
            nextDayDelivery: product.nextDayDelivery,
            productImageUrl: product.imageUrl
        )
    }
    
    private func clearValues() {
        totalPages = 1
        nextPage = 1
        searchQuery = ""
        products.removeAll()
        reloadProducts?()
    }
}
