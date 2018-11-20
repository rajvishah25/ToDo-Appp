 //
//  AddTaskViewController.swift
//  ToDo Appp
//
//  Created by Rajvi Shah on 10/24/18.
//  Copyright © 2018 Rajvi Shah. All rights reserved.
//

import UIKit

 
class AddTaskViewController: UIViewController {
@IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context)
        task.taskName = textfield.text!
        task.isImportant=isImp.isOn
        //save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    

}
