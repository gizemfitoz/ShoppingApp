//
//  ShoppingServiceSpy.swift
//  ShoppingAppTests
//
//  Created by Gizem Fitoz on 25.02.2022.
//

@testable import ShoppingApp
import Service
import Foundation

final class ShoppingServiceSpy: ShoppingServiceProtocol {
    var testErrorCase = false
    var searchProductsCalled = false
    var completion: ((Result<SearchResponse, Error>) -> Void)?
    var query = ""
    var page = 0
    
    func searchProducts(with query: String, page: Int, _ completion: @escaping ((Result<SearchResponse, Error>) -> Void)) {
        searchProductsCalled = true
        self.completion = completion
        self.query = query
        self.page = page
    }
    
    func callTheCompletion(result: Result<SearchResponse, Error>) {
        self.completion?(result)
    }
}
