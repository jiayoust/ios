//
//  ViewController.swift
//  Filter
//
//  Created by 崔树芹 on 19/4/14.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var image:UIImage!
    var flag=0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        image=UIImage(named: "SkyDrive340.png")
        imageview.image=image
        label.text=""
        
    }

    
    @IBAction func changevalue(_ sender: Any) {
        
        let seg=sender as! UISegmentedControl
        if seg.selectedSegmentIndex==0
        {
            flag=0
        }
        else
        {
            flag=1
        }
    }
    
    
    @IBAction func sliderchange(_ sender: Any) {
        
        let slider=sender as! UISlider
        var value:Float=slider.value
        if flag==0
        {
            
            filterSpiaTone(value)
        }
        else
        {
            filterGaus(value)
            
            
        }
        
    }
    
    func filterSpiaTone(_ value:Float)
    {
        let context=CIContext(options: nil)
        let cimage=CIImage(cgImage: self.image.cgImage!)
        
        if let sepiaTone=CIFilter(name: "CISepiaTone")
        {
            sepiaTone.setValue(cimage, forKey: "inputImage")
            let text=String(format:"旧色调 %f",value)
            self.label.text=text
            sepiaTone.setValue(value, forKey: "inputIntensity")
            let result=sepiaTone.value(forKey: "outputImage") as! CIImage
            
            let imageRef=context.createCGImage(result, from: CGRect(x: 0, y: 0, width:self.imageview.image!.size.width, height: self.imageview.image!.size.height))
            
            let image=UIImage(cgImage: imageRef!)
            
            self.imageview.image=image
        }
        flag=0
        
        }
        
    func filterGaus(_ value:Float)
    {
        let context=CIContext(options: nil)
        let cimage=CIImage(cgImage: self.image.cgImage!)
        
        if let Guss=CIFilter(name: "CIGaussianBlur")
        {
            Guss.setValue(cimage, forKey: "inputImage")
            let text=String(format:"GUss  Radius %f",value*10)
            NSLog(text)
            self.label.text=text
            Guss.setValue(value, forKey: "inputRadius")
            let result=Guss.value(forKey: "outputImage") as! CIImage
            
            let imageRef=context.createCGImage(result, from: CGRect(x: 0, y: 0, width:self.imageview.image!.size.width, height: self.imageview.image!.size.height))
            
            let image=UIImage(cgImage: imageRef!)
            
            self.imageview.image=image
        }
        flag=1
        
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

