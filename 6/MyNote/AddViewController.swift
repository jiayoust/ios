//
//  AddViewController.swift
//  MyNote
//
//  Created by 崔树芹 on 19/4/16.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class AddViewController: UIViewController ,UITextFieldDelegate{
    
    
    @IBOutlet weak var image: UIImageView!



    @IBOutlet weak var txt1: UITextField!
    
   
    @IBOutlet weak var txt2: UITextField!
    //业务逻辑对象BL
    var bl = NoteBL()
    var imagepath:String!

    var list:[String:String]=["image": "6", "name": "aaa"]
    
    
    @IBAction func Cance(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Save(_ sender: Any) {
        let person = Note()
        person.name=self.txt1.text!
       
        person.number = self.txt2.text!
        person.imagepath=self.imagepath
        print(person.imagepath)
      
        let reslist = bl.create(person)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadViewNotification"),
                                        object: reslist,
                                        userInfo: nil)
        
        self.txt1.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        
  
        self.txt1.delegate=self

        imagepath=String(format:"%@.png",list["image"]!)
    
        
        self.image.image=UIImage(named:imagepath)
     

        self.txt1.becomeFirstResponder()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
