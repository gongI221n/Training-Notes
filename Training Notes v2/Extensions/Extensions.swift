//
//  Extensions.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 30.01.2022.
//

import Foundation
import UIKit

extension WorkoutListForClientViewController: UITextViewDelegate {
    
    // Метод вызвается во время редактирование текста в UItextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = view.backgroundColor
    }
    
    // Метод вызывается после окончания редактирования текста в UItextView
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = view.backgroundColor
        
    }
    
}

extension NewClientsTableViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        return true
    }
}

extension NewWorkoutTableViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        return true
    }
}

extension NewClientsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        statusArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectStatus = statusArray[row]
        statusTF.text = selectStatus
    }
    
}

var selectStatus: String?
let statusArray = ["Не выбран", "Оффлайн", "Онлайн"]
