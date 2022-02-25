//
//  DoubleExtensions.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 26.02.2022.
//

import Foundation

extension Double {
    var eurPrice: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "EUR"
        numberFormatter.currencyDecimalSeparator = "."
        numberFormatter.currencyGroupingSeparator = ","
        let number = NSNumber(value: self)
        return numberFormatter.string(from: number)
    }
}
