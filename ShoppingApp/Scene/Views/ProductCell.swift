//
//  ProductCell.swift
//  ShoppingApp
//
//  Created by Gizem Fitoz on 24.02.2022.
//

import UIKit
import SDWebImage

final class ProductCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!
    @IBOutlet weak var nextDayDeliveryLabel: UILabel!
    
    func setup(_ viewModel: ProductCellViewModel) {
        productImageView.sd_setImage(with: viewModel.productImageUrl)
        productNameLabel.text = viewModel.productName
        salesPriceLabel.text = viewModel.salesPrice
        nextDayDeliveryLabel.isHidden = !viewModel.nextDayDelivery
    }
}
