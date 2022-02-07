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
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) { // Передаю данные из NewClientsTableViewController в ClientsTableViewController
        guard let newClientVC = segue.source as? NewClientsTableViewController else { return }
        newClientVC.saveNewClient() // вызов метода сохранения в базу данных
        tableView.reloadData()
    }
    
    // MARK: - Передача имени из ClientsTableViewCell в label внутри WorkoutListForClientViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToWorkoutList" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return }
            let client = clientsBase[indexPath.row]
            let NameClientVC = segue.destination as! WorkoutListForClientViewController
            NameClientVC.currentName = client
        }

    }

    
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
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // Удаление объекта
        if editingStyle == .delete {
            let client = clientsBase[indexPath.row]
            StorageManager.deleteClient(client)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
     
    
    // MARK: Table view delegate
    // Метод удаления объекта из базы. - Работает, но он пока избыточен, так как метод предполагает добавление сразу нескольких действий открывающихся после свайпа.
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { // Смахиваине справо на лево
//
//        let client = clientsBase[indexPath.row]
//        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_  in
//            StorageManager.deleteClient(client) // Удаление из базы
//            tableView.deleteRows(at: [indexPath], with: .automatic) // Удаление строки
//        }
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
}
