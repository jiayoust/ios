//
//  ScheduleViewController.swift
//  Olympics
//
//  Created by 崔树芹 on 19/5/1.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {
    
    var data:[String:[Schedule]]!
    var gamelist:[String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if self.data==nil||self.data.count==0
        {
            let bl=ScheduleBL()
            self.data=bl.readData()
            let keys=self.data.keys
            self.gamelist=keys.sorted(by:<)
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return gamelist.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let date=gamelist[section]
        let s=self.data[date]!
        return s.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

       let gamedate=gamelist[indexPath.section]
        let schedules=data[gamedate]
        let sche=schedules![indexPath.row]
        
        cell.textLabel?.text=sche.GameTime
        
        cell.detailTextLabel?.text=String(format: "%@|%@",sche.GameInfo!,sche.Event!.EventName!)

        return cell
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date=gamelist[section]
        return date
    }
    override func  sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listTitles=[String]()
        for item in gamelist
        {
            let title=(item as NSString).substring(from:5)
            listTitles.append(title)
        }
        return listTitles
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
