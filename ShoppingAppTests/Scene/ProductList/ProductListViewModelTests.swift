//
//  ProductListViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Gizem Fitoz on 25.02.2022.
//

import XCTest
@testable import ShoppingApp
import Service

final class ProductListViewModelTests: XCTestCase {
    private var viewModel: ProductListViewModel!
    private var service: ShoppingServiceSpy!
    
    override func setUp() {
        self.service = ShoppingServiceSpy()
        self.viewModel = ProductListViewModel(service: service)
    }
    
    func testViewDidLoad() {
        // Given
        var loaderValues: [Bool] = []
        viewModel.loader = { value in
            loaderValues.append(value)
        }
        
        var reloadProductsCalled = false
        viewModel.reloadProducts = {
            reloadProductsCalled = true
        }
        
        var showErorCalled = false
        viewModel.showError = { _ in
            showErorCalled = true
        }
        
        // When
        viewModel.viewDidLoad()
        service.callTheCompletion(result: .success(getSearchResponse()))
        
        // Then
        XCTAssertTrue(loaderValues[0])
        XCTAssertFalse(loaderValues[1])
        XCTAssertEqual(service.query, "")
        XCTAssertEqual(service.page, 1)
        XCTAssertTrue(reloadProductsCalled)
        XCTAssertFalse(showErorCalled)
    }
    
    func testGetProductsWithError() {
        // Given
        var loaderValues: [Bool] = []
        viewModel.loader = { value in
            loaderValues.append(value)
        }
        
        var reloadProductsCalled = false
        viewModel.reloadProducts = {
            reloadProductsCalled = true
        }
        
        var showErorCalled = false
        viewModel.showError = { _ in
            showErorCalled = true
        }
        
        // When
        viewModel.viewDidLoad()
        service.callTheCompletion(result: .failure(ServiceError("error")))
        
        // Then
        XCTAssertTrue(loaderValues[0])
        XCTAssertFalse(loaderValues[1])
        XCTAssertEqual(service.query, "")
        XCTAssertEqual(service.page, 1)
        XCTAssertFalse(reloadProductsCalled)
        XCTAssertTrue(showErorCalled)
    }
    
    func testSearchProducts() {
        // Given
        var loaderValues: [Bool] = []
        viewModel.loader = { value in
            loaderValues.append(value)
        }
        
        var reloadProductsCalled = false
        viewModel.reloadProducts = {
            reloadProductsCalled = true
        }
        
        var showErorCalled = false
        viewModel.showError = { _ in
            showErorCalled = true
        }
        
        // When
        viewModel.searchProducts(with: "apple")
        service.callTheCompletion(result: .success(getSearchResponse()))
        
        // Then
        XCTAssertTrue(loaderValues[0])
        XCTAssertFalse(loaderValues[1])
        XCTAssertEqual(service.query, "apple")
        XCTAssertEqual(service.page, 1)
        XCTAssertTrue(reloadProductsCalled)
        XCTAssertFalse(showErorCalled)
    }
    
    func testCancelSearch() {
        // Given
        var loaderValues: [Bool] = []
        viewModel.loader = { value in
            loaderValues.append(value)
        }
        
        var reloadProductsCalled = false
        viewModel.reloadProducts = {
            reloadProductsCalled = true
        }
        
        var showErorCalled = false
        viewModel.showError = { _ in
            showErorCalled = true
        }
        
        // When
        viewModel.cancelSearch()
        service.callTheCompletion(result: .success(getSearchResponse()))
        
        // Then
        XCTAssertTrue(loaderValues[0])
        XCTAssertFalse(loaderValues[1])
        XCTAssertEqual(service.query, "")
        XCTAssertEqual(service.page, 1)
        XCTAssertTrue(reloadProductsCalled)
        XCTAssertFalse(showErorCalled)
    }
    
    func testNumberOfRowsInSection() {
        // Given
        viewModel.getProducts()
        service.callTheCompletion(result: .success(getSearchResponse()))
        // When
        let number = viewModel.numberOfRowsInSection(section: 0)
        // Then
        XCTAssertEqual(number, 22)
    }
    
    func testCellViewModel() {
        // Given
        viewModel.getProducts()
        service.callTheCompletion(result: .success(getSearchResponse()))
        // When
        let cellViewModel = viewModel.cellViewModel(at: 0)
        // Then
        XCTAssertEqual(cellViewModel.productName, "Apple iPhone X 256GB Zilver")
        XCTAssertEqual(cellViewModel.salesPrice, "Price: 1279.0")
        XCTAssertEqual(cellViewModel.nextDayDelivery, true)
        XCTAssertEqual(cellViewModel.productImageUrl?.absoluteString, "https://image.coolblue.nl/300x750/products/984921")
    }
    
    private func getSearchResponse() -> SearchResponse {
        let data = getResourceAsData("search-response", ext: "json")
        return try! JSONDecoder().decode(SearchResponse.self, from: data!)
    }
    
    private func getResourceAsData(_ fileName: String, ext: String) -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: fileName, withExtension: ext) else { return nil }
        return try? Data(contentsOf: url)
    }
}
