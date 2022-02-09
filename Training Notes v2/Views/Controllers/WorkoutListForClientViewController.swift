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
    @IBOutlet weak var clientStatusLabel: UILabel!
    
    var currentName: Clients? // Буферная переменная с данными ячейки, по которой происходит переход
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self // Данный (этот) UI берет на себя функции делегата
        
        // Кастомизация textView
//        textView.backgroundColor = self.view.backgroundColor // Цвет фона textView как у цвет фона контроллера.
        textView.textColor = .white
        textView.font?.withSize(17)

        clientNameLabel.font.withSize(20)
        clientNameLabel.numberOfLines = 0
        clientNameLabel.textColor = .white
        
        setupScreen()
        createToolbar() // Вызов метода создания toolbar
        
        // Observers для отслеживания скрытия и появления клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification: )),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification: )),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    private func setupScreen() { // Метод срабатывает, если тапнуть по ячейке в ClientTableViewController
        if currentName != nil {
            clientNameLabel.text = currentName?.name
            clientStatusLabel.text = currentName?.status
        }
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
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // "Невидимое пространство для смещения кнопки "Готово" к правому краю

        toolbar.setItems([flexibleSpace, doneButton], animated: true) // Размещение кнопок из массива в toolbar
        toolbar.isUserInteractionEnabled = true // Позволяем взаимодействовать пользователю с данным элементом
        
        textView.inputAccessoryView = toolbar // Встраиваем toolbar при нажатии на textView
        
    }
    
    @objc func dismissKeyboard() { // Метод скрытия клавиатуры по нажатию на кнопку (хз, почему из obj-c)
        view.endEditing(true)
    }
    
    // TODO: - не верно съезжает клавиатура - исправить.
    @objc func updateTextView (notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any], // Информация о размере клавиатуры
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue // Присваиваем размер клавиатуры, хранится в userInfo[UIResponder.keyboardFrameEndUserInfoKey и возвращает объект с типом Any? и нужно привести его к типу NSValue, а потом все привести к типу cgRectValue.
                // Теперь объект keyboardFrame является прямоугольников, в котором определены все 4 стороны.
        else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification { // Условие при скрытии клавиатуры
            textView.contentInset = UIEdgeInsets.zero // Определяет расстояние от текста до нижней границе textView и необходимо это расстояние обнулить
        } else { // Если клавиатура будет появляться - необходимо поднять текст
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - 50, right: 0) // Расстояние между текстом и нижней границей textView на расстоянии равное высоте клавиатуры (-50 поинтов из-за нижнего TabBar (50 поинтов взял из головы на глаз)
            textView.scrollIndicatorInsets = textView.contentInset // Сдвигаем индикатор прокрутки на расстояние равное textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange) // Зона видимости скроллинга
    }
    
}


