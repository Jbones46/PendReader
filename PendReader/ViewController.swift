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
    @IBOutlet weak var medianTempLbl: UILabel!
    @IBOutlet weak var medianWindLbl: UILabel!
    @IBOutlet weak var medianPressureLbl: UILabel!
    
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var periodSegment: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       //queryFirebase()
      
       
       findMean()
        var test = datePicker.date
        print(test)
        
       // print("DmySNap = \(mySnap)")

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
    let sample = "2012-01-01 08:00:00 +0000"
    let url = "https://weatherdataapp.firebaseio.com/Data/Mean"
    let url2 = "https://weatherdataapp.firebaseio.com/Data/Median"

var mySnap: FDataSnapshot?
    var mySnap2: FDataSnapshot?
    func findMean() {
        
        var mySnapArray = [FDataSnapshot]()
                let ref = Firebase(url: url)
                let ref2 = Firebase(url: url2)
     let mySpef = ref.observeEventType(.Value, withBlock: { snapshot in
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                func snappers() -> FDataSnapshot {
                for snap in snapshots {
                    if self.mySnap == nil {
                        self.mySnap = snap.childSnapshotForPath(self.sample)}
                    
                   // print(self.mySnap)
                
//                    mySnapArray.append(snap)
//                     print(mySnapArray)
                }
                print(self.mySnap)
            return self.mySnap!
                }
            let dSnap = snappers()
              //  print("snappers = \(dSnap)")
                
             // print("Temp: \(dSnap.valueForKey("Temp"))")
               // print("Temp: \(dSnap.valueForKeyPath("Temp"))")
                
                let bSnap = dSnap.valueInExportFormat() as! [String: Double]
                let temp = bSnap["Temp"]
                let baro = bSnap["Barometric"]
                let windSpeed = bSnap["WindSpeed"]
                print(bSnap["Temp"])
                print(bSnap["Barometric"])
                self.tempLbl.text = String(format: "%.2f", temp!) + " / "
                self.pressureLbl.text = String(format: "%.2f", baro!) + " / "
                self.windLbl.text = String(format: "%.2f", windSpeed!) + " / "
                
                
                //print(bSnap)
                self.mySnap = dSnap
            
            }
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
       
        let mySpef2 = ref2.observeEventType(.Value, withBlock: { snapshot2 in
            
            if let snapshots2 = snapshot2.children.allObjects as? [FDataSnapshot] {
                func snappers2() -> FDataSnapshot {
                    for snap2 in snapshots2 {
                        if self.mySnap2 == nil {
                            self.mySnap2 = snap2.childSnapshotForPath(self.sample)}
                        
                        // print(self.mySnap)
                        
                        //                    mySnapArray.append(snap)
                        //                     print(mySnapArray)
                    }
                    print(self.mySnap2)
                    return self.mySnap2!
                }
                let dSnap2 = snappers2()
                //  print("snappers = \(dSnap)")
                
                // print("Temp: \(dSnap.valueForKey("Temp"))")
                // print("Temp: \(dSnap.valueForKeyPath("Temp"))")
                
                let bSnap2 = dSnap2.valueInExportFormat() as! [String: Double]
                print(bSnap2)
                let temp2 = bSnap2["Temp"]
                let baro2 = bSnap2["Barometric"]
                let windSpeed2 = bSnap2["WindSpeed"]
                print(bSnap2["Temp"])
                print(bSnap2["Barometric"])
                self.medianTempLbl.text = String(format: "%.2f", temp2!)
                self.medianPressureLbl.text = String(format: "%.2f", baro2!)
                self.medianWindLbl.text = String(format: "%.2f", windSpeed2!)
                
                
                //print(bSnap)
                self.mySnap2 = dSnap2
                
            }
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        
    }
    
    
    
 }

