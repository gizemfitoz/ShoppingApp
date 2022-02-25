//
//  BaseViewController.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 25.02.2022.
//

import UIKit

class BaseViewController: UIViewController {
    var indicatorview = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(indicatorview)
        indicatorview.center = self.view.center
    }
    
    func showError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showLoadingView() {
        indicatorview.startAnimating()
    }
    
    func hideLoadingView() {
        indicatorview.stopAnimating()
    }
}
