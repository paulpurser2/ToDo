//
//  ViewController.swift
//  ToDo
//
//  Created by Paul Purser on 6/21/18.
//  Copyright © 2018 Paul Purser. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Task 1", "Task 2", "Task 3"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        //give the cell some text
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
   //TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row]) //prints the string in the console corresponding to the element in the array ****
    
        //the below conditonal statement checks off the cell when you select the cell after you check it off and checks it when you select it
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(textField.text!) //we unwrap because never gonna be nil since we are ALWAYS placing a string or text inside the textField
            
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

