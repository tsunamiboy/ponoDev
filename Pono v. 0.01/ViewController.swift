//
//  ViewController.swift
//  Pono v. 0.01
//
//  Created by David Blake on 8/17/16.
//  Copyright © 2016 Sea Turtle Dreams. All rights reserved.
//

/*
 TO-DO
 DONE Compress 3 stop buttons to 1
 DONE Compress 3 timer labels to 1
 DONE Display time totals of all apps
 DONE Change switch into For..In loop in upDateClock for (applic, appTime) in itemDict
 DONE in updateClock, allow for variable number of cases
            experiment: replace IBOutlets with subviews
        Enable selection of the relevant table entry is selected within one function
        Enable selection of appName value from A Dictionary
        Enable radio button selection
        Enable creation of the Dictionary key by input from text
        Use random generation of value
        Enable creation of the Dictionary value by drag and Drop of objects
        Enable collection of the app... by detecting object id

 */


import UIKit

class ViewController: UIViewController {

    
    let clock = Clock()
    
    @IBOutlet weak var clockViewLabel: UILabel!
    
    
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var label04: UILabel!
    @IBOutlet weak var label05: UILabel!
    @IBOutlet weak var label06: UILabel!
    @IBOutlet weak var label07: UILabel!
    @IBOutlet weak var label08: UILabel!
    @IBOutlet weak var label09: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!


    @IBOutlet weak var timerViewLabel: UILabel!
    
    @IBOutlet weak var errCodeViewLabel: UILabel!
    
//    var time = NSDate()
    
    var clockTimer: Timer?
    
    var itemDict: [String: Int ] = [:]
    var appName = "none"
    var elapsedTime = 0

    
    var seconds = 0
    var timer = Timer()
    var timerIsOn = false
   
    func loadDictItem(_ item: String) {
        itemDict[(item)] = 0
    }
    
    func updateClock() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        clockViewLabel.text = "\(formatter.string(from: clock.currentTime as Date))"
//  this loop continuously displays total times used.
                if itemDict.values.isEmpty {
                }
                    else {
                    var labelCnt = 0
                    let sortedKeys: Array = (itemDict as NSDictionary).keysSortedByValue(comparator: { ($1 as! NSNumber ).compare($0 as! NSNumber ) })
//                    let sortedKeys:Array = (itemDict as NSDictionary).keysSortedByValueUsingSelector(#selector(NSNumber.compare(_:)))
                        for applic in sortedKeys {
                            let appTime = itemDict["\(applic)"]
                            print("\(applic): \(appTime)")
                            switch labelCnt {
                                case 0 : label01.text = "\(applic)"; label02.text = "\(appTime!)"
                                case 1 : label03.text = "\(applic)"; label04.text = "\(appTime!)"
                                case 2 : label05.text = "\(applic)"; label06.text = "\(appTime!)"
                                case 3 : label07.text = "\(applic)"; label08.text = "\(appTime!)"
                                case 4 : label09.text = "\(applic)"; label10.text = "\(appTime!)"
                                case 5 : label11.text = "\(applic)"; label12.text = "\(appTime!)"
                                default:
                                    errCodeViewLabel.text = "appName= \(applic) Time= \(appTime)"
                                }
                            labelCnt += 1
                            }
                        }
        }

    func updateTimer() {
        seconds += 1
        timerViewLabel.text = "\(seconds)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateClock)), userInfo: nil, repeats: true)
        
/*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.updateClock), name: UIApplicationWillEnterForegroundNotification, object: nil)
            }
*/

    }

    deinit {
        //        NSNotificationCenter.defaultCenter().removeObserver(self)
        timer.invalidate()
        clockTimer?.invalidate()
    }   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateClock()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*
     compress 3 timer-refresh labels to 1
*/
    
    @IBAction func refreshButton(_ sender: AnyObject) {
        //        timer.invalidate()
        seconds = 0
        timerViewLabel.text = "\(seconds)"
    }

    @IBAction func stopButton(_ sender: AnyObject) {
        if timerIsOn == false {
            errCodeViewLabel.text = "Timer is not running"
        }
        if timerIsOn {
            var totalTimeUsed = itemDict[appName]!
//            var totalTimeUsed = itemDict["A"]!
                        print("appName: \(appName) Total: \(itemDict[appName]!)")
            totalTimeUsed = totalTimeUsed + seconds
                        print("total + timer: \(totalTimeUsed)")
            itemDict[appName] = totalTimeUsed
                        print("appName: \(appName) Total: \(itemDict[appName]!)")
                        print("\(appName) Timer stopped.")
            timer.invalidate()
            timerIsOn = false
        }
    }
    
    @IBAction func itemAStartButton(_ sender: AnyObject) {
        if itemDict["A"] == nil {
            loadDictItem("A")
        }
        if timerIsOn == false {
            appName = "A"
            timerViewLabel.text = "0"
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func itemBStartButton(_ sender: AnyObject) {
        if itemDict["B"] == nil {
            loadDictItem("B")
        }
        if timerIsOn == false {
            appName = "B"
            timerViewLabel.text = "0"
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func itemCStartButton(_ sender: AnyObject) {
        if itemDict["C"] == nil {
            loadDictItem("C")
        }
        if timerIsOn == false {
            appName = "C"
            timerViewLabel.text = "0"
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    @IBAction func itemDStartButton(_ sender: AnyObject) {
        if itemDict["D"] == nil {
            loadDictItem("D")
        }
        if timerIsOn == false {
            appName = "D"
            timerViewLabel.text = "0"
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func itemEStartButton(_ sender: AnyObject) {
        if itemDict["E"] == nil {
            loadDictItem("E")
        }
        if timerIsOn == false {
            appName = "E"
            timerViewLabel.text = "0"
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func itemFStartButton(_ sender: AnyObject) {
        if itemDict["F"] == nil {
            loadDictItem("F")
        }
        if timerIsOn == false {
            appName = "F"
            timerViewLabel.text = "0"
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
}
