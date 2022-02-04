//
//  WorkoutTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 15.01.2022.
//

import UIKit

class WorkoutTableViewController: UITableViewController {

    var workouts = [
        Workout(name: "Приседания со штангой"),
        Workout(name: "Жим штанги лежа"),
        Workout(name: "Вертикальная тяга")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSugue(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        let sourceVC = segue.source as! NewWorkoutTableViewController
        let workout = sourceVC.newWorkout
        
        let newIndexPath = IndexPath(row: workouts.count, section: 0)
        workouts.append(workout)
        tableView.insertRows(at: [newIndexPath], with: .fade)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return workouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutTableViewCell
        let workoutCell = workouts[indexPath.row]
        cell.setupWorkout(workout: workoutCell)

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            workouts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    //Перемещение внутри объектов Tableview + перемещение внутри массива
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedClients = workouts.remove(at: sourceIndexPath.row)
        workouts.insert(movedClients, at: destinationIndexPath.row)
        tableView.reloadData()
    }

    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
