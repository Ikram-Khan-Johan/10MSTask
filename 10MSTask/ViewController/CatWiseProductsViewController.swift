//
//  CatWiseProductsViewController.swift
//  10MSTask
//
//  Created by Johan on 18/3/23.
//

import UIKit

class CatWiseProductsViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var products: Products = []
    var categoryId: Int = 0
    var cvcDelegate: CVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = products[0].category.capitalized
        registerCell()
        // Do any additional setup after loading the view.
    }

    func configureCell(_products: Products) {
        self.products = _products
    }
  
    func categoryId(id: Int){
        self.categoryId = id
        print("Cat id ", categoryId)
    }
    private func registerCell(){

        categoryCollectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }

}

extension CatWiseProductsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.productTitleLabel.text = product.title
        cell.productPriceLabel.text = "$\(product.price)"
        cell.layer.cornerRadius = 10
        if let url = URL(string: product.image) {
            cell.productImageView.sd_setImage(with: url)
        }
        else {
            print("No Image Found")
        }
        return cell
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width/2) - 20, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //print("Item Selected ", indexPath)
        let product = products[indexPath.row]
        cvcDelegate?.onSelectItem(product: product)
    
    }
    
}
