//
//  ViewController.swift
//  ToDo Appp
//
//  Created by Rajvi Shah on 10/24/18.
//  Copyright © 2018 Rajvi Shah. All rights reserved.
//

import UIKit

var tasks : [Task] = []
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.taskName
        //cell.accessoryType = UITableViewCell.AccessoryType()
        if task.isImportant{
            cell.textLabel?.text = "🔔\(task.taskName!)"
        }
        let accessory: UITableViewCell.AccessoryType = task.done ? .checkmark : .none
        cell.accessoryType = accessory
        
        return cell
    }
 /*  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle(rawValue: 3)!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let tasks = tasks.objectAtIndex(indexPath.row) as String
        let itemId = tasks.componentsSeparatedByString("$%^")
        // remove from self.selectedItems
        tasks[itemId[1]] = nil
    }
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* let tasks = item.objectAtIndex(indexPath.row) as String
        let itemId = tasks.componentsSeparatedByString("$%^")
        // add to self.selectedItems
        tasks[itemId[1]] = true*/
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < tasks.count
        {
            let item = tasks[indexPath.row]
            item.done = !item.done
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
 
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if(editingStyle == .delete){
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                tasks = try context.fetch(Task.fetchRequest())
            } catch{
                print("failed")
            }
            
        }
        tableView.reloadData()
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        tasks = try context.fetch(Task.fetchRequest())
        } catch{
            print("failed")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        //gets data from coredata with getData()
        getData()
        
        //reloads the tableview
        tableView.reloadData()
    }
  

}

