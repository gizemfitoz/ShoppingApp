//
//  ServiceError.swift
//  
//
//  Created by Gizem Fitoz on 24.02.2022.
//

import Foundation

struct ServiceError : LocalizedError {
    private var message : String

    init(_ description: String) {
        message = description
    }
}
