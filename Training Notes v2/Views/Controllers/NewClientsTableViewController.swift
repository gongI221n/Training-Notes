//
//  NewClientsTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit

class NewClientsTableViewController: UITableViewController {

//    var newClient = Clients()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choiceStatusPicker()
        createToolbar()
        updateSaveButtonState()
//        DispatchQueue.main.async { // Фоновый поток.
//            self.newClient.saveClients()
//        }
        
    }
    
    func choiceStatusPicker() { // PickerView вместо клавиатуры
        let clientStatus = UIPickerView()
        clientStatus.delegate = self
        statusTF.inputView = clientStatus //При тапе на это поле выходит PickerView, а не клавиатура
    }
    
    private func updateSaveButtonState() { // Метод для включения кнопки "Сохранить"
        let nameText = nameTF.text ?? ""
        let statusText = statusTF.text ?? "Статус не выбран"
        saveButton.isEnabled = !nameText.isEmpty && !statusText.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) { // Отслеживание введеного текста в поле для активации кнопки "Сохранить"
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // Сегвей по кнопке "Сохранить"
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let name = nameTF.text ?? ""
        let status = statusTF.text ?? "Статус не выбран"
        
//        self.newClient = Clients(name: name, status: status)
    }
 
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit() // Размер toolbar под ширину клавиатуры
        
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // "Невидимое пространство для смещения кнопки "Готово" к правому краю

        toolbar.setItems([flexibleSpace, doneButton], animated: true) // Размещение кнопок из массива в toolbar
        toolbar.isUserInteractionEnabled = true // Позволяем взаимодействовать пользователю с данным элементом
        
        statusTF.inputAccessoryView = toolbar // Встраиваем toolbar при нажатии на PickerView
        
    }
    
    @objc func dismissKeyboard() { // Метод скрытия клавиатуры по нажатию на кнопку (хз, почему из obj-c)
        view.endEditing(true)
    }
    
    // TODO: - Метод выхода по кнопке Отмена. Но почему то не работает. Доделать позже. Сейчас выход осуществляется через unwindeSegue
    //@IBAction func cancelAction(_ sender: Any) { // Action кнопки Отмена - выходит из контроллера и выгружает его их памяти
//        dismiss(animated: true, completion: nil)
//    }
    
    func saveNewClient() {
        
        let newClient = Clients(name: nameTF.text!, status: statusTF.text!)
        
        StorageManager.saveClient(newClient)
        
        
        // Если нет инициализатора в Model и внутри класса нашей модели
//        newClient.name = nameTF.text!
//        newClient.status = statusTF.text!
        
    }
    
}
