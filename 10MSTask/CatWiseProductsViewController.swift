//
//  CatWiseProductsViewController.swift
//  10MSTask
//
//  Created by Johan on 18/3/23.
//

import UIKit

class CatWiseProductsViewController: UIViewController {

    var products: Products = []
    var categoryId: Int = 0
    var cvcDelegate: CVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        print("I am running")
        // Do any additional setup after loading the view.
    }
    

    func configureCell(_products: Products) {
        self.products = _products
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func categoryId(id: Int){
        self.categoryId = id
        print("Cat id ", categoryId)
    }

}

extension CatWiseProductsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Hello")
        return Array(productDict)[categoryId].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatWiseCollectionViewCell", for: indexPath) as! CatWiseCollectionViewCell
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "\(product.price)"
        //cell.titleLabel.text = "HUrrah"
        //cell.priceLabel.text = "200"
//        cell.productImageView.image = UIImage(named: "img_onboarding_4")
       
        if let url = URL(string: product.image) {
            cell.productImageView.load(url: url)
        }
        else {
            print("No Image Found")
        }
        return cell
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item Selected ", indexPath)
        let product = products[indexPath.row];       cvcDelegate?.onSelectItem(product: product)
    
    }
    
}
