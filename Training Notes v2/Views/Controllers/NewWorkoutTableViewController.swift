//
//  NewWorkoutTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 16.01.2022.
//

import UIKit

class NewWorkoutTableViewController: UITableViewController {

    var newWorkout = Workout()
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Активации кнопки "Сохранить"
        saveButton.isEnabled = false
        nameTF.addTarget(self, action: #selector(textChanged), for: .editingChanged)

    }
    
    
    @objc private func textChanged(_ sender: UITextField) { // Метод активации кнопки "Сохранить"
        if nameTF.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "SaveSegue" else { return }
//        let name = nameTF.text ?? ""
//
////        self.newWorkout = Workout(name: name)
//    }

    func saveNewWorkout() { // Метод сохранения в базу данных
        
        let newWorkout = Workout(name: nameTF.text!)
        
        // Если нет инициализатора в Model и внутри класса нашей модели
//        newClient.name = nameTF.text!
//        newClient.status = statusTF.text!
        
        StorageManager.saveWorkout(newWorkout)
        
    }
    
}
