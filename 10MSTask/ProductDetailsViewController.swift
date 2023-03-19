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
        // Do any additional setup after loading the view.
    }
    
    func showProductDetails(){
        guard let product = product else {
            print("No product found")
            return}
        titleLabel.text = product.title
        categoryLabel.text = product.category.capitalized
        ratingLabel.text = "Rating: "+String(product.rating.rate)
        totalCountLabel.text = "Total Review: "+String(product.rating.count)
        descriptionLabel.text = product.description + "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32."
        if let url = URL(string: product.image) {
            productImageView.load(url: url)
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
