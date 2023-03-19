//
//  DelegateViewController.swift
//  10MSTask
//
//  Created by Johan on 19/3/23.
//

import UIKit

class DelegateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
}


extension DelegateViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DelegateTVC", for: indexPath) as! DelegateTVC
        cell.delegate = self
        return cell
    }
    
    
    
    
}
extension DelegateViewController: TVCDelegate {
    
    func tappedCalled() {
        print("tapped called in VC")
    }
    
    
}
