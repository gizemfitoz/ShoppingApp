//
//  ServiceError.swift
//  
//
//  Created by Gizem Fitoz on 24.02.2022.
//

import Foundation

public struct ServiceError : LocalizedError {
    private var message : String

    public init(_ description: String) {
        message = description
    }
}
