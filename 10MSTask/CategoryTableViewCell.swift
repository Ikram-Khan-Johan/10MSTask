//
//  CategoryTableViewCell.swift
//  10MSTask
//
//  Created by Johan on 16/3/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return data[section].movies.count
        print("total products ",section, Array(productDict)[collectionView.tag].value.count)
        return Array(productDict)[collectionView.tag].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.tag = indexPath.row
        cell.nameLabel.text = Array(productDict)[collectionView.tag].value[indexPath.row].title
        cell.priceLabel.text = String(Array(productDict)[collectionView.tag].value[indexPath.row].price)
        let iconLink = Array(productDict)[collectionView.tag].value[indexPath.row].image

        if let url = URL(string: iconLink) {
            cell.imageView.load(url: url)
        } else {
            print("image url not found")
        }
        //cell.imageView.image = UIImage(named: "img_onboarding_4")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
