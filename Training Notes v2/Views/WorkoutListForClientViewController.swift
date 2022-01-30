//
//  WorkoutListViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 30.01.2022.
//

import UIKit

class WorkoutListForClientViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var clientNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self // Данный (этот) UI берет на себя функции делегата
        
        // Кастомизация textView
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .white
        textView.font?.withSize(17)
        
        // Доделать метод отображения label. Текст для label должен быть по названию ячейки (подопечного)
//        clientNameLabel.text =
        clientNameLabel.text = "Здесь будет имя подопечного, а пока членом мне по губам за незнание."
        clientNameLabel.font.withSize(20)
        clientNameLabel.numberOfLines = 0
        clientNameLabel.textColor = .white
        
        createToolbar() // Вызов метода создания toolbar
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // Скрывает клавиатуру вызванной для любого объекта
        
//        textView.resignFirstResponder() // Скрывает клавиатуру вызванную для конкретного объекта
    }

    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit() // Размер toolbar под размер toollbar
        
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true) // Размещение кнопок из массива в toolbar
        toolbar.isUserInteractionEnabled = true // Позволяем взаимодействовать пользователю с данным элементом
        
        textView.inputAccessoryView = toolbar // Встраиваем toolbar при нажатии на textView
        
    }
    
    @objc func dismissKeyboard() { // Метод скрытия клавиатуры по нажатию на кнопку (хз, почему из obj-c)
        view.endEditing(true)
    }
    
}
