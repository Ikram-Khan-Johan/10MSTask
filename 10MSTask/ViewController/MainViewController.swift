//
//  MainViewController.swift
//  10MSTask
//
//  Created by Johan on 16/3/23.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    let refreshControl = UIRefreshControl()
    var productDict = [String: [Product]]()
    var loader: UIAlertController! = nil
    @IBOutlet weak var categoryTableView: UITableView!
    
    var products: Products?
    let baseURL: String = "https://fakestoreapi.com/products"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString("")
        refreshControl.addTarget(self, action: #selector(self.refresh(_sender:)), for: .valueChanged)
        categoryTableView.addSubview(refreshControl)
        categoryTableView.sectionHeaderTopPadding = 0
        self.navigationItem.title = "Ecommerce"
        categoryTableView.register(MyCustomHeader.self,
                                   forHeaderFooterViewReuseIdentifier: "sectionHeader")
        self.loader = self.loader()
        fetchProductData(url: baseURL) { [weak self] result in
            guard let self = self else {return}
            self.products = result
            self.findCategory(products: self.products!)
            DispatchQueue.main.async {
                self.stopLoader(loader: self.loader)
                self.categoryTableView.reloadData()
            }
        }
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
    @objc func refresh(_sender: AnyObject) {
        //self.loader = loader()
        fetchProductData(url: baseURL) { [weak self] result in
            guard let self = self else {return}
            self.products = result
            self.findCategory(products: self.products!)
            DispatchQueue.main.async {
               
                self.categoryTableView.reloadData()
                //self.stopLoader(loader: self.loader)
                self.refreshControl.endRefreshing()
            }
        }
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


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 240
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray5
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                "sectionHeader") as! MyCustomHeader
        view.title.text = Array(productDict)[section].key.capitalized
        view.title.font = view.title.font.withSize(20)
        view.title.font = UIFont.boldSystemFont(ofSize: 17)
        view.title.shadowColor = .white
        view.title.shadowOffset = CGSize(width: 1, height: 1)

        view.button.setTitle("See All", for: UIControl.State.normal)
        view.button.setTitleColor(.systemBlue, for: UIControl.State.normal)
        view.button.backgroundColor = .white
        view.button.layer.cornerRadius = 15
        view.button.tag = section
        view.button.addTarget(self, action: #selector(self.onClickSeeAllButton(button:)), for: .touchUpInside)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
