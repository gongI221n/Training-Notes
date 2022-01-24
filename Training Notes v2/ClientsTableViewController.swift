//
//  ClientsTableViewController.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 14.01.2022.
//

import UIKit

class ClientsTableViewController: UITableViewController {
    
    var clients = [
        Clients(name: "Ivan"),
        Clients(name: "Petr"),
        Clients(name: "Oleg")
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.title = "Подопечные"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSugue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewClientsTableViewController
        let client = sourceVC.newClient
        
        let newIndexPath = IndexPath(row: clients.count, section: 0)
        clients.append(client)
        tableView.insertRows(at: [newIndexPath], with: .fade)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientsCell", for: indexPath) as! ClientsTableViewCell
        let clientsCell = clients[indexPath.row]
        cell.setup(client: clientsCell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            clients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedClients = clients.remove(at: sourceIndexPath.row)
        clients.insert(movedClients, at: destinationIndexPath.row)
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
