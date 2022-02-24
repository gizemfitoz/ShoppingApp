//
//  ShoppingService.swift
//  
//
//  Created by Gizem Fitoz on 22.02.2022.
//

import Alamofire
import Foundation

final public class ShoppingService: ShoppingServiceProtocol {
    let session: Session = Session(eventMonitors: [ServiceLogger()])

    public init() {}

    public func searchProducts(with query: String, page: Int, _ completion: @escaping ((Result<SearchResponse, Error>) -> Void)) {
        let url = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/mobile-assignment/search"

        var parameters: [String: String] = [:]

        parameters["page"] = String(page)

        if !query.isEmpty {
            parameters["query"] = query
        }

        session.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: SearchResponse.self) { response in
            guard let searchResponse = response.value else {
                completion(.failure(ServiceError("Error fetching the products page #\(page)!")))
                return
            }
            completion(.success(searchResponse))
        }
    }
}


