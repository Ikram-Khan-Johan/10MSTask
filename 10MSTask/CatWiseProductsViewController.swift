//
//  CatWiseProductsViewController.swift
//  10MSTask
//
//  Created by Johan on 18/3/23.
//

import UIKit

class CatWiseProductsViewController: UIViewController {

    var categoryId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        print("I am running")
        // Do any additional setup after loading the view.
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatWiseCollectionViewCell", for: indexPath) as! CatWiseCollectionViewCell
        cell.titleLabel.text = Array(productDict)[categoryId].value[indexPath.row].title
        cell.priceLabel.text = String(Array(productDict)[categoryId].value[indexPath.row].price)
        //cell.titleLabel.text = "HUrrah"
        //cell.priceLabel.text = "200"
        cell.productImageView.image = UIImage(named: "img_onboarding_4")
        return cell
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: 200)
    }
    
}
