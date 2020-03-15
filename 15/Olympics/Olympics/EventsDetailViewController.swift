//
//  EventsDetailViewController.swift
//  Olympics
//
//  Created by 崔树芹 on 19/5/1.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    var event:Events!

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var imaEventIcon: UIImageView!
    
    
    override func viewDidLoad() {
               super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imaEventIcon.image=UIImage(named: event.EventIcon!)
        eventName.text=event.EventName
        text.text=event.KeyInfo
        
        
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
