//
//  ViewController.swift
//  ToDo
//
//  Created by Paul Purser on 6/21/18.
//  Copyright © 2018 Paul Purser. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]() //pulls from item array of item objects
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Task 1"
        itemArray.append(newItem)
       
        let newItem2 = Item()
        newItem2.title = "Task 2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Task 3"
        itemArray.append(newItem3)
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
           itemArray = items
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// Lets input the tableview data source methods
    
    //Every tableView needs a number of rows so this is essential for any tableviewController
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        //give the cell some text
        cell.textLabel?.text = item.title
        
        //TERNARY OPERATOR - READ in notes
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
   //TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row]) //prints the string in the console corresponding to the element in the array ****
        
        //this sets the done property of the itemArray to the opposite of what it is right now
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Add new items with the plus button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //adds a UIPopUpTab or an alert when the plus button is clicked by the user
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default)
        { (action) in
            //what happens when person clicks plus button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem) //we unwrap because never gonna be nil since we are ALWAYS placing a string or text inside the textField
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
        
        //a textfield inside a popup Tab
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

