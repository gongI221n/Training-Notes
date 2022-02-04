//
//  NewClientsTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit

class NewClientsTableViewController: UITableViewController {

    var newClient = Clients(name: "")
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTF: UITextField!
    //    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButtonState()
               
    }

    private func updateSaveButtonState() {
        let nameText = nameTF.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) { // Отслеживание введеного текста к поле для активации кнопки "Сохранить"
        updateSaveButtonState()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let name = nameTF.text ?? ""
        
        self.newClient = Clients(name: name)
    }
 
    
    
}
