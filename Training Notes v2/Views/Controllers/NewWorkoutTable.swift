//
//  NewWorkoutTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 16.01.2022.
//

import UIKit

class NewWorkoutTable: UITableViewController {

    var newWorkout = Workout(name: "")
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSaveButtonState()
    }

    
    private func updateSaveButtonState() {
        let nameText = nameTF.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "SaveSegue" else { return }
        let name = nameTF.text ?? ""
        
        self.newWorkout = Workout(name: name)
    }

}
