//
//  ClientsTableViewCell.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit

class ClientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
//    func setup (client: Clients) {
//        
//        self.textLabel?.text = client.name
//        
//    }
    
}
