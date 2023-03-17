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


class MainViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    var products: Products?
    let baseURL: String = "https://fakestoreapi.com/products"
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProductData(url: baseURL) { result in
            self.products = result
            
            print(self.products![2].title )
        }
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
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].sectionType
    }
    
}
struct MovieData {
    let sectionType: String
    let movies: [String]
}
