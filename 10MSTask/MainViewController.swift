//
//  MainViewController.swift
//  10MSTask
//
//  Created by Johan on 16/3/23.
//

import UIKit
var data = [MovieData(sectionType: "Action", movies: ["007", "Mission Impossible", "Mission Impossible2"]),
            MovieData(sectionType: "Science Fiction", movies: ["007", "Mission Impossible", "Mission Impossible2"]),
            MovieData(sectionType: "Drama", movies: ["007", "Mission Impossible", "Mission Impossible2"]),
            MovieData(sectionType: "Love Story", movies: ["007", "Mission Impossible", "Mission Impossible2"])
]
var categories: [String] = []
var productDict = [String: [Product]]()
class MainViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    var products: Products?
    let baseURL: String = "http://139.162.30.73:2424/products"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProductData(url: baseURL) { result in
            self.products = result
            self.findCategory(products: self.products!)
            //print(self.products![7].category )
            //print("Ta da", categories)
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func findCategory(products: Products) {

        for i in products {
            //print("Hello ",i.id)
       
            if !categories.contains(i.category) {
                categories.append(i.category)
            }
            let keyExists = productDict[i.category] != nil
            if keyExists==false {
                productDict[i.category] = [i]
            } else {
                productDict[i.category]?.append(i)
            }
            //print(keyExists, i.id)
        }
        print(productDict["electronics"]?.count)
        print(productDict["jewelery"]?.count)
        print(productDict["men's clothing"]?.count)
        print(productDict["women's clothing"]?.count)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchProductData(url: String, completion: @escaping (Products)-> Void){
        guard let url = URL(string: url) else {
            print("url String convert failed")
            return
        }
        
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data else {
                print("data not found!")
                return
            }
            
            if error == nil {
                
                do {
                    let parsedData = try JSONDecoder().decode(Products.self, from: data)
                    completion(parsedData)
                } catch {
                    print("parsing error")
                }
                
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        
        dataTask.resume()
    }
}


extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryCollectionView.tag = indexPath.section
        //print("tag ",cell.categoryCollectionView.tag)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return data.count
        return productDict.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(productDict)[section].key
    }
    
}
struct MovieData {
    let sectionType: String
    let movies: [String]
}

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
