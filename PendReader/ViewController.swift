//
//  ViewController.swift
//  PendReader
//
//  Created by Justin Ferre on 11/8/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var periodSegment: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

