//
//  ViewController.swift
//  AddDelCell
//
//  Created by 崔树芹 on 19/4/17.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UITextFieldDelegate {
    
    
    @IBOutlet var txtField: UITextField!
    var list:NSMutableArray!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem=self.editButtonItem
        self.navigationItem.title="单元格插入和删除"
       // txtField.isHidden=true
        self.txtField.delegate=self
        self.list=NSMutableArray(array: ["apple","orange","peach"])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count+1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var badd=(indexPath.row==list.count)
        var cell:UITableViewCell!=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        if badd==false
        {
            cell.textLabel?.text=list[indexPath.row] as? String
            
            
        }
        else
        {
            //txtField.frame=CGRect(x: 10, y: 5, width: 300, height: 44)
            cell.contentView.addSubview(txtField)
        }
        return cell
        
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        
        if indexPath.row==list.count
        {
            return .insert
            
        }
        else
        {
            return .delete
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var indexPaths=[indexPath]
        
        if editingStyle == .delete
        {
            list.removeObject(at: indexPath.row)
            tableView.deleteRows(at: indexPaths, with: .fade)
            
        }
        else if editingStyle == .insert
        {
            list.insert(txtField.text, at:list.count)
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
  /*  override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: true)
        if editing
        {
        
            txtField.isHidden = false
        }
        else
        {
            txtField.isHidden = true
            
        }
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

