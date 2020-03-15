//
//  imageTableViewController.swift
//  MyNote
//
//  Created by  柳嘉丽 on 2019/5/10.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class imageTableViewController: UITableViewController {
    
    var list:[Any]!
    var data:[String]!
    var name:String!

    override func viewDidLoad() {

        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let plishpath=Bundle.main.path(forResource: "team", ofType: "plist")
        let array=NSArray(contentsOfFile:plishpath!)
        let array2=NSDictionary(contentsOfFile:plishpath!)
        self.list=array as! [Any]
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let row=indexPath.row
        let rowDirt=self.list[row] as! [String:String]
      
        let imagepath=String(format:"%@.png",rowDirt["image"]!)

        cell.imageView?.image=UIImage(named:imagepath)

        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show2" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let addview=segue.destination as! AddViewController
                let index = self.tableView.indexPathForSelectedRow as! IndexPath?
                let selected=index!.row
             
                let rowDirt1=self.list[selected] as! [String:String]
                addview.list = rowDirt1
                

            }
        }
}

    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show2" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let addview=segue.destination as! AddViewController
            
            let index = self.tableView.indexPathForSelectedRow as! IndexPath?
                
                var dataDict=[String:String]()

                let selected=index!.row
                //print(selected)
             addview.index=selected
             print(addview.index)
            
            
                //let rowDirt1=self.list[index!.row] as! [String:String]
                //let imagepath1=String(format:"%@.png",rowDirt1["image"]!)
           // addview.list = self.list[name] as! [[String:String]]
                //dataDict["image"]=imagepath1
                //NotificationCenter.default.post(name: Notification.Name(rawValue:"reload2ViewNotification"), object: nil,userInfo:dataDict)

                
            }
        }
    }*/


    
 

    
    // Override to support conditional editing of the table view.
   /* override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        
        var dataDict=[String:String]()
        let index = self.tableView.indexPathForSelectedRow
        //let selected=index!.row
        print(index)
       
        let rowDirt1=self.list[indexPath.row] as! [String:String]
        let imagepath1=String(format:"%@.png",rowDirt1["image"]!)
        
        dataDict["image"]=imagepath1
        NotificationCenter.default.post(name: Notification.Name(rawValue:"reload2ViewNotification"), object: nil,userInfo:dataDict)

        return true
    }*/
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
