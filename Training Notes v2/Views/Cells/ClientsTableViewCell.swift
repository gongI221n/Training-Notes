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
    
    
    func setup (client: Clients) {
        
        self.nameLabel.text = client.name
        self.statusLabel.text = client.status
    }
    
    
}
