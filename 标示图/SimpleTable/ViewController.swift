//
//  ViewController.swift
//  SimpleTable
//
//  Created by 崔树芹 on 19/3/7.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit


 class ViewController : UITableViewController {

    
    var dictdata:[String:AnyObject]!
    var listgroupname:[String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let plistpath=Bundle.main.path(forResource: "team", ofType: "plist")
       if let dict=NSDictionary(contentsOfFile: plistpath!)
       {
        dictdata=dict as! [String:AnyObject]
        
        let templist=dict.allKeys as! [String]
        self.listgroupname=templist.sorted(by:<)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.listgroupname.count
    }
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let groupname=self.listgroupname[section]
        let  listTeams=self.dictdata[groupname]
        return listTeams!.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:UITableViewCell=tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        
        let section=indexPath.section
        let row=indexPath.row
        let groupname=self.listgroupname[section]
        
        let listteams=self.dictdata[groupname]
        
        let rowdict=listteams![row] as! [String:String]
        cell.textLabel?.text=rowdict["name"]
        let imagepath=String(format: "%@.png", rowdict["image"]!)
        cell.imageView?.image=UIImage(named: imagepath)
        
        cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupname=self.listgroupname[section]
        return groupname
        
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listtitles=[String]()
        for item in self.listgroupname
        {
          let title=(item as AnyObject).substring(to: 1)as String
        listtitles.append(title)
        }
        return listtitles
        
    }

}

