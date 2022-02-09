//
//  Extensions.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 30.01.2022.
//

import Foundation
import UIKit

var selectStatus: String?
let statusArray = ["", "Не выбран", "Оффлайн", "Онлайн"]

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

extension ClientsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { // Вызываем метод поиска
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // Фильтрация контента в соответствии с поисковым запросом
    private func filterContentForSearchText(_ searchText: String){
        
        filtredClients = clientsBase.filter("name CONTAINS[c] %@ OR status CONTAINS[c] %@", searchText, searchText) // Будет производиться поиск по параметрам имя и статус не смотря на регистр текста.
        //В доках на Realm есть примеры как фильтровать из базы.
        tableView.reloadData()
    }
    
}


