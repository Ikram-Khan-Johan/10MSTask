//
//  CategoryTableViewCell.swift
//  10MSTask
//
//  Created by Johan on 16/3/23.
//

import UIKit
protocol CVCDelegate {
    func onSelectItem(product: Product)
}

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var products: Products?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        // Initialization code
    }
    
    func configureCell(_products: Products) {
        self.products = _products
        categoryCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cvcDelegate: CVCDelegate?

}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        let product = products?[indexPath.row]
        
        cell.nameLabel.text = product?.title
        cell.priceLabel.text = "$\(product?.price ?? 0)"
        //cell.layer.borderColor = UIColor.blue.cgColor
           // cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        if let url = URL(string: product?.image ?? "") {
            cell.imageView.load(url: url)
        } else {
            print("image url not found")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item Selected ", indexPath)
        guard let product = products?[indexPath.row] else { return }
        cvcDelegate?.onSelectItem(product: product)
    
    }
}
