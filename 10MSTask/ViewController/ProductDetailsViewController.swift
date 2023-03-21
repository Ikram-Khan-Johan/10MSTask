//
//  ProductDetailsViewController.swift
//  10MSTask
//
//  Created by Johan on 19/3/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productScrollView: UIScrollView!
    var product: Product?
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        productScrollView.contentSize = CGSize(width: productScrollView.contentSize.width, height: 2000)
        showProductDetails()
        self.title = product?.title
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
    
    func showProductDetails(){
        guard let product = product else {
            print("No product found")
            return}
        titleLabel.text = product.title
        categoryLabel.text = product.category.capitalized
        ratingLabel.text = "Rating: "+String(product.rating.rate)
        totalCountLabel.text = "Total Review: "+String(product.rating.count)
        descriptionLabel.text = product.description
        if let url = URL(string: product.image) {
            productImageView.sd_setImage(with: url)
        } else {
            print("image url not found")
        }
        
    }
    func productData(product: Product ){
        
        self.product = product
        print("Title ", product.title)
        print("ID ", product.id)
    }
    
}
