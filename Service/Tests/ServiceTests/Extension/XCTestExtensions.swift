//
//  File.swift
//  
//
//  Created by Gizem Fitoz on 23.02.2022.
//

import XCTest

extension XCTest {
    func getResourceAsData(_ fileName: String, ext: String) -> Data? {
        guard let url = Bundle.module.url(forResource: fileName, withExtension: ext) else { return nil }
        return try? Data(contentsOf: url)
    }
}
