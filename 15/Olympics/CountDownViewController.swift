//
//  CountDownViewController.swift
//  Olympics
//
//  Created by 崔树芹 on 19/5/1.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {

    @IBOutlet weak var lbCountDown: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //创建NSDateComponents对象
        var comps = DateComponents()
        //设置NSDateComponents日期
        comps.day = 5
        //设置NSDateComponents月
        comps.month = 8
        //设置NSDateComponents年
        comps.year = 2016
        
        //创建日历对象
        let calender = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        
        //获得2016-8-5日的NSDate日期对象
        let destinationDate = calender!.date(from: comps)
        
        let date = Date()
        
        //获得当前日期到2016-8-5时间的NSDateComponents对象
        let components = calender!.components(NSCalendar.Unit.day, from: date , to:destinationDate!)
        
        //获得当前日期到2016-8-5相差的天数
        let days = components.day
        

        print("\(days)")
        let s=String(format: "%i 天", days!)
        
        lbCountDown.text=s
        
        
        
        
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
