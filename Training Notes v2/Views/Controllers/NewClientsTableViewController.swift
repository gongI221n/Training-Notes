//
//  NewClientsTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit

class NewClientsTableViewController: UITableViewController {

    var newClient = Clients(name: "", status: "")
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Сломался метод updateSaveButtonState() после добавления PickerView - Доделать позже
//        updateSaveButtonState()
        choiceStatusPicker()

        
    }

    func choiceStatusPicker() { // PickerView вместо клавиатуры
        let clientStatus = UIPickerView()
        clientStatus.delegate = self
        statusTF.inputView = clientStatus //При тапе на это поле выходит PickerView, а не клавиатура
    }
    
    private func updateSaveButtonState() { // Метод для включения кнопки "Сохранить"
        let nameText = nameTF.text ?? ""
        let statusText = statusTF.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !statusText.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) { // Отслеживание введеного текста в поле для активации кнопки "Сохранить"
        updateSaveButtonState()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // Сегвей по кнопке "Сохранить"
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let name = nameTF.text ?? ""
        let status = statusTF.text ?? ""
        
        self.newClient = Clients(name: name, status: status)
    }
 
    
    
}
