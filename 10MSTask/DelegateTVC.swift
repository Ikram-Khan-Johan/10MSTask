//
//  DelegateTVC.swift
//  10MSTask
//
//  Created by Johan on 19/3/23.
//

import UIKit

protocol TVCDelegate {
    func tappedCalled()
}

class DelegateTVC: UITableViewCell {

    @IBAction func tapped(_ sender: Any) {
        print(#function)
        delegate?.tappedCalled()
        
    }
    
    var delegate: TVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
