//
//  ProductDetailsViewController.swift
//  10MSTask
//
//  Created by Johan on 19/3/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    var product: Product?
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        showProductDetails()
        // Do any additional setup after loading the view.
    }
    
    func showProductDetails(){
        guard let product = product else {
            print("No product found")
            return}
        titleLabel.text = product.title
        categoryLabel.text = product.category
        ratingLabel.text = String(product.rating.rate)
        totalCountLabel.text = String(product.rating.count)
        descriptionLabel.text = product.description
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
