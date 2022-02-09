//
//  ClientsTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit
import RealmSwift

class ClientsTableViewController: UITableViewController {
    
    var searchController = UISearchController(searchResultsController: nil) // Экземпляр класса UISearchController

    var clientsBase: Results<Clients>! // Автообновляемй тип контейнера, который возвращает запрашиваемые данные. Текущее состояние хранилища в текущем потоке. Можем записывать и считывать данные
    var filtredClients: Results<Clients>! // Отфильтрованный массив клиентов
    var searchBarIsEmpty: Bool { // Если строка поиска будет пустой, то вернется значение true
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool { // Отслеживание активности строки поиска. Возвращает true, когда строка поиска активна и не пустая.
        return searchController.isActive && searchBarIsEmpty != true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // Снятие запрета взаимодествовать с отображаемым контентом поиска.
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController // Интегрирую строку поиска в навигейшн бар.
        definesPresentationContext = true // Позволяет отпустить строку поиска при переходе на другой экран.

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
            let client: Clients
            if isFiltering { // Если поиск активен, то переход будет осуществляться на ячейку отфильтрованного клиента, а не из обычного списка склиентов.
                client = filtredClients[indexPath.row]
            } else {
            client = clientsBase[indexPath.row]
            }
            let NameClientVC = segue.destination as! WorkoutListForClientViewController
            NameClientVC.currentName = client
        }

    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { // Если поиск активирован, то возвращает .count массива отфильтрованных клиентов.
            return filtredClients.count
        }
        return clientsBase.isEmpty ? 0 : clientsBase.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientsCell", for: indexPath) as! ClientsTableViewCell
        
        var clientCell = Clients()
        
        if isFiltering { // Если поиск активирован, то отображается отфильтрованный список, если нет, то обычный
            clientCell = filtredClients[indexPath.row]
        } else {
            clientCell = clientsBase[indexPath.row]
        }
        
//        let clientsCell = clientsBase[indexPath.row]
        
        cell.nameLabel.text = clientCell.name
        cell.statusLabel.text = clientCell.status
        
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
