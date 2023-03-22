//
//  Extension.swift
//  10MSTask
//
//  Created by Johan on 22/3/23.
//

import Foundation
import UIKit

extension UIViewController {
    func loader()->UIAlertController {
        let alert = UIAlertController(title: "", message: "Please Wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 30, y: 15, width: 30, height: 30))
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        
        alert.view.addSubview(indicator)
        self.present(alert, animated: true)
        return alert
    }
    func stopLoader(loader: UIAlertController) {
        
        DispatchQueue.main.async {
            loader.dismiss(animated: true)
        }
        
    }
}
