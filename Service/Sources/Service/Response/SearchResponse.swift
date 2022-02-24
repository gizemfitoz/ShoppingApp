//
//  SearchResponse.swift
//  
//
//  Created by Gizem Fitoz on 22.02.2022.
//

public struct SearchResponse: Codable {
    public let products: [Product]
    public let currentPage: Int
    public let pageSize: Int
    public let totalResults: Int
    public let pageCount: Int
    
    public struct Product: Codable {
        public let id: Int
        public let name: String
        public let salesPrice: Double
        public let imageUrl: String?
        public let nextDayDelivery: Bool

        enum CodingKeys: String, CodingKey {
            case id = "productId"
            case name = "productName"
            case salesPrice = "salesPriceIncVat"
            case imageUrl = "productImage"
            case nextDayDelivery
        }
    }
}
