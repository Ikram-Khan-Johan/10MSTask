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
    @objc func onClickSeeAllButton(button: UIButton){
       
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatWiseProductsViewController") as! CatWiseProductsViewController
           // guard let person = self.person else {print("no data found");
               // return}
            //nextViewController.sendUserData(person: person)
        nextViewController.categoryId(id: button.tag)
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated:true)
            
        
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
        print("tag ",cell.categoryCollectionView.tag)
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

class MyCustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    //let image = UIImageView()
    let button = UIButton()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        //image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

       // contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(button)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
//            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            image.widthAnchor.constraint(equalToConstant: 50),
//            image.heightAnchor.constraint(equalToConstant: 50),
//            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.widthAnchor.constraint(equalToConstant: 200),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
