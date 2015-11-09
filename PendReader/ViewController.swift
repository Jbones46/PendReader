//
//  ViewController.swift
//  PendReader
//
//  Created by Justin Ferre on 11/8/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import UIKit
import Firebase

let baseUrl = "https://weatherdataapp.firebaseio.com"


class ViewController: UIViewController {
    
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var periodSegment: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        testData()
        let calendar = NSCalendar.currentCalendar()
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        let earliestDate = calendar.dateWithEra(1, year: 2012, month: 01, day: 01, hour: 00, minute: 00, second: 00, nanosecond: 00)
        datePicker.minimumDate = earliestDate
        
        let yesterday = calendar.dateByAddingUnit(NSCalendarUnit.NSCalendarCalendarUnit, value: -1, toDate: NSDate(), options: .WrapComponents)
        
        datePicker.maximumDate = yesterday
        let thisDayYesterday = calendar.dateByAddingUnit(NSCalendarUnit.NSYearCalendarUnit, value: -1, toDate: NSDate(), options: .WrapComponents)
        
        datePicker.date = thisDayYesterday!
        
        
       datePicker.addTarget(self, action: "fetchData:", forControlEvents: UIControlEvents.ValueChanged)
        periodSegment.addTarget(self, action: "fetchData:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        
        
    }
    
    func fetchData(control: UIControl) {
        let startDate = NSCalendar.currentCalendar().dateBySettingHour(8, minute: 0, second: 0, ofDate: datePicker.date, options: .WrapComponents)
        
        var endDate = startDate
        
        switch periodSegment.selectedSegmentIndex {
        case 0:
            //first option - 1 day of data
            endDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: startDate!, options: .WrapComponents)
        case 1:
            //second option = 1 week of data
            endDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 7, toDate: startDate!, options: .WrapComponents)
        case 2:
            endDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: startDate!, options: .WrapComponents)
            
        default:
            break
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testData() {
        let sample = "2012-01-01 08:00:00 +0000"
        let url = "https://weatherdataapp.firebaseio.com/Data/Mean"
        let ref = Firebase(url: url)
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots{
                    print(snap)} }
            }, withCancelBlock: { error in
                print(error.description)
        })
        //print(myTest)
        
        
        
    }

}

