//
//  ViewController.swift
//  SaveList
//
//  Created by WangQi on 16/8/21.
//  Copyright © 2016年 WangQi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // Model
    var items = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    
    @IBAction func addName(sender: AnyObject) {
        
        let alert = UIAlertController(
            title: "New",
            message: "Add a new",
            preferredStyle: .Alert
        )
        
        let saveAction = UIAlertAction(
            title: "Save",
            style: .Default,
            handler: { (action: UIAlertAction) -> Void in
                
                let textField = alert.textFields!.first
                self.saveName(textField!.text!)
                self.tableView.reloadData()
            }
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    func saveName(name: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName(
            "Items",
            inManagedObjectContext: managedContext
        )
        let item = NSManagedObject(
            entity: entity!,
            insertIntoManagedObjectContext: managedContext
        )
        item.setValue(name, forKey: "name")
        
        // saving to Core Data
        
        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let item = items[indexPath.row]
        
        cell!.textLabel!.text = item.valueForKey("name") as? String
        return cell!
    }

    // fetching from Core Data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Items")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            items = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    

}

