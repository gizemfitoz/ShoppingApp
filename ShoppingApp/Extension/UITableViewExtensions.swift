//
//  UITableViewExtensions.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 25.02.2022.
//

import UIKit

extension UITableView {
    func register(cell: String) {
        self.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Noto Sans Oriya", size: 16)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
