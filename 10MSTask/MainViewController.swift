//
//  MainViewController.swift
//  10MSTask
//
//  Created by Johan on 16/3/23.
//

import UIKit
//var data = [MovieData(sectionType: "Action", movies: ["007", "Mission Impossible", "Mission Impossible2"]),
//            MovieData(sectionType: "Science Fiction", movies: ["007", "Mission Impossible", "Mission Impossible2"]),
//            MovieData(sectionType: "Drama", movies: ["007", "Mission Impossible", "Mission Impossible2"]),
//            MovieData(sectionType: "Love Story", movies: ["007", "Mission Impossible", "Mission Impossible2"])
//]

class MainViewController: UIViewController {
    
    var productDict = [String: [Product]]()
    
    @IBOutlet weak var categoryTableView: UITableView!
    var products: Products?
    let baseURL: String = "https://fakestoreapi.com/products"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.register(MyCustomHeader.self,
                                   forHeaderFooterViewReuseIdentifier: "sectionHeader")
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
            let keyExists = productDict[i.category] != nil
            if keyExists==false {
                productDict[i.category] = [i]
            } else {
                productDict[i.category]?.append(i)
            }
            //print(keyExists, i.id)
        }
        
    }
    
    @objc func onClickSeeAllButton(button: UIButton){
        
        let products = Array(productDict)[button.tag].value
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatWiseProductsViewController") as! CatWiseProductsViewController
        nextViewController.cvcDelegate = self
        nextViewController.categoryId(id: button.tag)
        nextViewController.configureCell(_products: products)
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return data.count
        return productDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        let products = Array(productDict)[indexPath.section].value
        cell.configureCell(_products: products)
        cell.cvcDelegate = self
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return Array(productDict)[section].key
    //    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        /* let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
         button.backgroundColor = .lightGray
         button.setTitle("See All >", for: .normal)
         button.tag = section
         //button.addTarget(self, action: #selector(self.buttonAction(button:)), for: .touchUpInside)
         return button*/
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                "sectionHeader") as! MyCustomHeader
        view.title.text = Array(productDict)[section].key
        view.button.titleLabel?.text = "See All >"
        view.button.setTitle("See All >", for: UIControl.State.normal)
        view.button.backgroundColor = .darkGray
        view.button.tag = section
        view.button.addTarget(self, action: #selector(self.onClickSeeAllButton(button:)), for: .touchUpInside)
        // view.image.image = UIImage(named: sectionImages[section])
        
        return view
    }
    
}

extension MainViewController: CVCDelegate {
    
    func onSelectItem(product: Product) {
        
        print("navigating to product page...")
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.productData(product: product)
        
        self.navigationController?.pushViewController(vc, animated: true)
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




