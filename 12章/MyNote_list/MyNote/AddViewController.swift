//
//  AddViewController.swift
//  MyNote
//
//  Created by 崔树芹 on 19/4/16.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class AddViewController: UIViewController ,UITextViewDelegate{

    @IBOutlet weak var txtView: UITextView!
    //业务逻辑对象BL
    var bl = NoteBL()
    
    
    @IBAction func Cance(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Save(_ sender: Any) {
        let note = Note()
        note.date = Date()
        note.content = self.txtView.text
        let reslist = bl.create(note)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadViewNotification"),
                                        object: reslist,
                                        userInfo: nil)
        
        self.txtView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.txtView.delegate = self
        self.txtView.text=""
        self.txtView.becomeFirstResponder()
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
