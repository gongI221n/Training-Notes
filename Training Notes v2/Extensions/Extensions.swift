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
