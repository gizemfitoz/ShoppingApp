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
    private let service: ShoppingService
    private var products: [SearchResponse.Product] = []
    private var isPaginating = false
    private var page = 0
    private var totalPages = 0
    private var searchQuery = "" {
        didSet {
            page = 0
        }
    }

    init(service: ShoppingService) {
        self.service = service
    }
    
    func viewDidLoad() {
        getProducts()
    }
    
    func getProducts() {
        if isPaginating || (totalPages != 0 && self.page == totalPages) {
            return
        }
        
        isPaginating = true
        page += 1

        loader?(true)
        service.searchProducts(with: searchQuery, page: page) { [weak self] result in
            guard let self = self else { return }
            self.loader?(false)
            
            self.isPaginating = false
            
            switch result {
            case let .success(response):
                self.totalPages = response.pageCount
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
        totalPages = 0
        page = 0
        searchQuery = ""
        products.removeAll()
        reloadProducts?()
    }
}
