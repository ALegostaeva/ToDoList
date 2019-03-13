//
//  ItemTableViewController.swift
//  ToDo-List
//
//  Created by Александра Легостаева on 05/03/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {

    var items = [Item]()
    
    func loadSampleItems() {
        //items += [Item(name:"Item 1"), Item(name:"Item 2"), Item(name:"Item 3")]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedItems = loadItems() {
            print(savedItems)
            items += savedItems
        } else {
            print("\(NSDate()) nothing to load")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        let item = items[indexPath.row]
        cell.nameLabel.text = item.name + item.date
        

        return cell
    }
    
    @IBAction func unwindToList (sender: UIStoryboardSegue) {
        let scrViewCon = sender.source as? ViewController
        let item = scrViewCon?.item
        if (scrViewCon != nil && item?.name != "") {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                items[selectedIndexPath.row] = item!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(item!)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
                saveItems()
                print("item added")
                
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at:indexPath.row)
            saveItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("item deleted")
        } else if editingStyle == .insert {
            
        }    
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

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let detailVC = segue.destination as! ViewController
            
            if let selectedCell = sender as? ItemTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = items[indexPath.row]
                detailVC.item = selectedItem
            } else if segue.identifier == "AddItem" {
                
            }
        }
    }
    
    func saveItems() {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            try data.write(to: Item.ArchiveURL)
            print("Items successfully saved.")
        } catch {
            print("Failed to save items...")
        }
    }
    

    /*func loadItems() -> [Item]? {
        if let nsData = NSData(contentsOf: Item.ArchiveURL) {
            let data = Data(referencing: nsData)
            
            if let loadedItems = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as Data) as? [Item] {
                print(loadedItems)
                return loadedItems
            } else {
                return []
            }
        
        }
    }*/
    
    
    func loadItems() -> [Item]? {
        
        if let data = NSData(contentsOf: Item.ArchiveURL) {
            do {
                //let data = Data(referencing: nsData)
                
                if let loadedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as Data) as? [Item] {
                    print(loadedItems)
                    return loadedItems
                }
            } catch {
                print("Couldn't read file")
                return nil
            }
        }
        return nil
    }
    
}
