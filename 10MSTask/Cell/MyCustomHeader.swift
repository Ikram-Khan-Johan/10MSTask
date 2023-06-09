//
//  MyCustomHeader.swift
//  10MSTask
//
//  Created by Johan on 19/3/23.
//

import Foundation
import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    
    let title = UILabel()
    let button = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(button)
        

        NSLayoutConstraint.activate([
           
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
