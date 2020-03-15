//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by 崔树芹 on 19/4/17.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    
    var events : NSArray!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let plistPath = Bundle.main.path(forResource: "events", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.events = NSArray(contentsOfFile: plistPath!)

    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return events.count/2
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! CollectionViewCell
        let event=events[indexPath.section*2+indexPath.row] as! NSDictionary
        
        cell.label.text=event["name"] as? String
        
        cell.imageView.image=UIImage(named: event["image"] as! String)
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event=events[indexPath.section*2+indexPath.row] as! NSDictionary
        NSLog("%@",event["name"] as! String)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

