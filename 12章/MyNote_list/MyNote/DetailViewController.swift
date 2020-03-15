//
//  DetailViewController.swift
//  MyNote
//
//  Created by 崔树芹 on 19/4/16.
//  Copyright © 2019年 csq. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

////aaaaa
    func configureView() {
        // Update the user interface for the detail item.
        if let detail:Note = self.detailItem  as? Note{
            if let label = self.detailDescriptionLabel {
                label.text = detail.content
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/////aaaa
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

