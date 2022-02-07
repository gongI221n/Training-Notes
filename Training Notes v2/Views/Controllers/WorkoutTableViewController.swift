//
//  WorkoutTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 15.01.2022.
//

import UIKit
import RealmSwift

class WorkoutTableViewController: UITableViewController {
    
    var workoutsBase: Results<Workout>!// Автообновляемй тип контейнера, который возвращает запрашиваемые данные. Текущее состояние хранилища в текущем потоке. Можем записывать и считывать данные
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.title = "Упражнения"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        workoutsBase = realm.objects(Workout.self)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) { // Передаю данные из NewWorkoutsTableViewController в WorkoutsTableViewController
        guard let newWorkoutsVC = segue.source as? NewWorkoutTableViewController else { return }
        newWorkoutsVC.saveNewWorkout()// вызов метода сохранения в базу данных
        tableView.reloadData()

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutsBase.isEmpty ? 0 : workoutsBase.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutTableViewCell
        let workoutCell = workoutsBase[indexPath.row]
        
        cell.textLabel?.text = workoutCell.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let workout = workoutsBase[indexPath.row]
            StorageManager.deleteWorkout(workout)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
