//
//  ProductCollectionViewCell.swift
//  10MSTask
//
//  Created by Johan on 21/3/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    public static let identifier = "\(#function)"
    public static let nib = UINib(nibName: "\(#function)", bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
