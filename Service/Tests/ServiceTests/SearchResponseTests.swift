//
//  SearchResponseTests.swift
//  
//
//  Created by Gizem Fitoz on 23.02.2022.
//

import XCTest
@testable import Service

final class SearchResponseTests: XCTestCase {
    func testConvertFromJson() {
        // Given
        guard let data = getResourceAsData("search-response", ext: "json") else {
            XCTFail()
            return
        }
        // When
        let response = try? JSONDecoder().decode(SearchResponse.self, from: data)
        // Then
        XCTAssertEqual(response?.currentPage, 1)
        XCTAssertEqual(response?.pageSize, 24)
        XCTAssertEqual(response?.totalResults, 2)
        XCTAssertEqual(response?.pageCount, 1)
        XCTAssertEqual(response?.products.count, 2)
        XCTAssertEqual(response?.products.first?.id, 785359)
        XCTAssertEqual(response?.products.first?.name, "Apple iPhone 6 32GB Grijs")
        XCTAssertEqual(response?.products.first?.salesPrice, 369)
        XCTAssertEqual(response?.products.first?.imageUrl, "https://image.coolblue.nl/300x750/products/818870")
        XCTAssertTrue(response?.products.first?.nextDayDelivery ?? false)
    }
}
