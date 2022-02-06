//
//  ClientsTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit
import RealmSwift

class ClientsTableViewController: UITableViewController {
    
    var clientsBase: Results<Clients>! // Автообновляемй тип контейнера, который возвращает запрашиваемые данные. Текущее состояние хранилища в текущем потоке. Можем записывать и считывать данные
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.title = "Подопечные"
        self.navigationItem.leftBarButtonItem = self.editButtonItem // Кнопка edit в левой части bar
        
        clientsBase = realm.objects(Clients.self)
    }
    
    @IBAction func unwindSugue(segue: UIStoryboardSegue) { // Передаю данные из NewClientsTableViewController в ClientsTableViewController
        guard let newClientVC = segue.source as? NewClientsTableViewController else { return }
        newClientVC.saveNewClient() // вызов метода сохранения в базу данных
        tableView.reloadData()
    }
    // TODO: - Доделать переход имени подопечного из ClientsTableViewCell в label внутри WorkoutListForClientViewController
//    var name1 = ""
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "GoToWorkoutList" else { return }
//        guard let destination = segue.destination as? WorkoutListForClientViewController else { return }
//        guard let destination1 = segue.destination as? ClientsTableViewCell else { return }
//
//        name1 = destination1.nameLabel.text!
//    }
//
//    @IBAction func saveData(_ unwindSegue: UIStoryboardSegue) {
//            guard unwindSegue.identifier == "passDataToFirstVC" else {
//                return
//            }
//            guard let source = unwindSegue.source as? WorkoutListForClientViewController else { return }
//        name1 = source.text
//        }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientsBase.isEmpty ? 0 : clientsBase.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientsCell", for: indexPath) as! ClientsTableViewCell
        let clientsCell = clientsBase[indexPath.row]
        
        cell.nameLabel.text = clientsCell.name
        cell.statusLabel.text = clientsCell.status
//        cell.setup(client: clientsCell)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: - Исправить ошибку с массивом client / clientsBase
            clients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Перемещение внутри объектов в Tableview + перемещение внутри массива
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedClients = clients.remove(at: sourceIndexPath.row)
        clients.insert(movedClients, at: destinationIndexPath.row)
        tableView.reloadData()
    }
     
}
