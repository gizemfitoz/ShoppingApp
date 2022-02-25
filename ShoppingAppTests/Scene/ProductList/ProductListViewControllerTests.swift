//
//  ProductListViewControllerTests.swift
//  ShoppingAppTests
//
//  Created by Gizem Fitoz on 25.02.2022.
//

import XCTest
@testable import ShoppingApp

final class ProductListViewControllerTests: XCTestCase {
    private var viewController: ProductListViewController!
    private var window: UIWindow!
    private var viewModel: ProductListViewModelSpy!
    
    override func setUp() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootViewController: ProductListViewController = UIStoryboard(name: "ProductList", bundle: nil)
            .instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        viewController = rootViewController
        viewModel = ProductListViewModelSpy()
        viewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewController.loadView()
    }
    
    func testViewDidLoad() {
        // When
        viewController.viewDidLoad()
        // Then
        XCTAssertEqual(viewController.title, "ProductsSpyTitle")
        XCTAssertNotNil(viewController.navigationItem.searchController)
        XCTAssertEqual(viewController.searchController.searchBar.placeholder, "Search Product..")
    }
    
    func testNumberOfRowsInSection() {
        // Given
        viewController.viewDidLoad()
        // When
        let rows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        // Then
        XCTAssertEqual(rows, 2)
    }
    
    func testCellForRowAtWhenProductHasNextDayDelivery() {
        // Given
        viewController.viewDidLoad()
        viewModel.testWithProductHasNextDayDelivery = true
        // When
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ProductCell
        // Then
        XCTAssertEqual(cell.productNameLabel.text, "name")
        XCTAssertEqual(cell.salesPriceLabel.text, "1")
        XCTAssertEqual(cell.nextDayDeliveryLabel.text, "Next Day Delivery!")
        XCTAssertFalse(cell.nextDayDeliveryLabel.isHidden)
    }
    
    func testCellForRowAtWhenProductHasNotNextDayDelivery() {
        // Given
        viewController.viewDidLoad()
        // When
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ProductCell
        // Then
        XCTAssertEqual(cell.productNameLabel.text, "name")
        XCTAssertEqual(cell.salesPriceLabel.text, "1")
        XCTAssertEqual(cell.nextDayDeliveryLabel.text, "Next Day Delivery!")
        XCTAssertTrue(cell.nextDayDeliveryLabel.isHidden)
    }
    
    func testScrollViewDidScrool() {
        // Given
        viewController.viewDidLoad()
        // When
        viewController.scrollViewDidScroll(UIScrollView())
        // Then
        XCTAssertTrue(viewModel.getProductsCalled)
    }
    
    func testSearchBarCancelButtonClicked() {
        // Given
        viewController.viewDidLoad()
        // When
        viewController.searchBarCancelButtonClicked(UISearchBar())
        // Then
        XCTAssertTrue(viewModel.cancelSearchCalled)
    }
    
    func testUpdateSearchResults() {
        // Given
        viewController.viewDidLoad()
        // When
        viewController.updateSearchResults(for: viewController.searchController)
        // Then
        XCTAssertTrue(viewModel.searchProductsCalled)
    }
    
    func testSearch() {
        // Given
        viewController.viewDidLoad()
        // When
        viewController.searchController.searchBar.text = "a"
        // Then
        XCTAssertTrue(viewModel.searchProductsCalled)
    }
    
    func testReloadProducts() {
        // Given
        let oldValue = viewModel.reloadProducts
        // When
        viewController.viewDidLoad()
        // Then
        let newValue = viewModel.reloadProducts
        XCTAssertNil(oldValue)
        XCTAssertNotNil(newValue)
    }
    
    func testLoader() {
        // Given
        let oldValue = viewModel.loader
        // When
        viewController.viewDidLoad()
        // Then
        let newValue = viewModel.loader
        XCTAssertNil(oldValue)
        XCTAssertNotNil(newValue)
    }
    
    func testShowError() {
        // Given
        let oldValue = viewModel.showError
        // When
        viewController.viewDidLoad()
        // Then
        let newValue = viewModel.showError
        XCTAssertNil(oldValue)
        XCTAssertNotNil(newValue)
    }
}
