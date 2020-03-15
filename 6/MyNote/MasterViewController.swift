//
//  MasterViewController.swift
//  MyNote
//
//  Created by 崔树芹 on 19/4/16.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
   // var objects = [Any]()

    //保存数据列表
    var listData = [Note]()
    //业务逻辑对象BL
    var bl = NoteBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

       // let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
       // self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
        //查询所有的数据
        self.listData = self.bl.findAll()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadView(_:)),
                                               name: Notification.Name(rawValue: "reloadViewNotification"),
                                               object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  /*  func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }*/

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail2" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = listData[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

       // let object = objects[indexPath.row] as! NSDate
       // cell.textLabel!.text = object.description
        
        let note = self.listData[indexPath.row]
        cell.textLabel!.text = note.name
        
        cell.detailTextLabel!.text = note.number.description
        cell.imageView?.image=UIImage(named:note.imagepath)
       
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = self.listData[indexPath.row]
            self.listData = bl.remove(note)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
        
       
        
        
    }
    // MARK: --处理通知
    func reloadView(_ notification: Notification) {
            let resList = notification.object as! [Note]
            self.listData = resList
            self.tableView.reloadData()
       
        }



}

