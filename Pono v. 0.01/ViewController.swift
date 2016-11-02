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
        multiple buttons, one timer
        set the tag property of button and do work based on the tag, case
 
 button.tag = 5
 button.addTarget(self,action:#selector(buttonClicked),
 forControlEvents:.TouchUpInside)
 
 func buttonClicked(sender:UIButton)
 {
 if(sender.tag == 5){
 
 var abc = "argOne" //Do something for tag 5
 }
 print("hello")
 }
        Starting any app stops timer of another app
        inactivity causes stop
        selection of the relevant table entry within one function
        appName:randomNum ... randomNum:timeUsed ... report by appName->timeUsed
        selection of appName value from A Dictionary
        radio button selection
        creation of the appName Dictionary key...
            by input from text
            by drag and Drop of objects
        identify app...
            detect object id
            by registration
            by alias

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
    var appRunning = "none"
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
                            print("upDateClock => \(applic): \(appTime)")
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
            print("stopButton => appName: \(appName) Total: \(itemDict[appName]!)")
            totalTimeUsed = totalTimeUsed + seconds
            print("stopButton => total + timer: \(totalTimeUsed)")
            itemDict[appName] = totalTimeUsed
            print("stopButton => appName: \(appName) Total: \(itemDict[appName]!)")
            print("stopButton => \(appName) Timer stopped.")
            timer.invalidate()
            seconds = 0
            timerViewLabel.text = "\(seconds)"
            appName = "none"
            appRunning = "none"
            timerIsOn = false
        }
    }
    
    func stopFunc() {
        if timerIsOn {
            var totalTimeUsed = itemDict[appName]!
            print("stopFunc => appName: \(appName) Total: \(itemDict[appName]!)")
            totalTimeUsed = totalTimeUsed + seconds
            print("stopFunc => total + timer: \(totalTimeUsed)")
            itemDict[appName] = totalTimeUsed
            print("stopFunc => appName: \(appName) Total: \(itemDict[appName]!)")
            print("stopFunc => \(appName) Timer stopped.")
            itemDict[appName] = totalTimeUsed
            timer.invalidate()
            seconds = 0
            timerViewLabel.text = "\(seconds)"
            appName = "none"
            appRunning = "none"
            timerIsOn = false
        }
    }
    
    func startTimer () {
        
        print("startTimer => Begin ...")
        print("      timerIsOn = \(timerIsOn)")
        print("      appName = \(appName)")
        print("     appRunning = \(appRunning)")
        if timerIsOn && appName != appRunning {
            print("... calling stopFunc ...")
            stopFunc()
        }
        if itemDict[appName] == nil {
            print("startTimer => ... App named \(appName) Not in Dict, calling loadDict ...")
            loadDictItem(appName)
        }
        timerViewLabel.text = "0"
        seconds = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        appRunning = appName
        timerIsOn = true
        print("startTimer => End ...")
        print("   timerIsOn = \(timerIsOn)")
        print("   appName = \(appName)")
        print("  appRunning = \(appRunning)")
    }
    
    
/*
     +  Starting any app stops timer of another app
            if label reps current app, do nothing or call
            (create) stop func
            start timer for new app
     +  Enable selection of the relevant table entry within one function
     +  Enable appName:randomNum ... randomNum:timeUsed ... report by appName->timeUsed
     collect appName from object selected
     determine if appName is in list of tracked apps
     and if not, load it for tracking
 */
    

    @IBAction func itemAStartButton(_ sender: AnyObject) {
        if appName != "A" {
            if appName != "none" {
            stopFunc()
            }
            appName = "A"
//        appName = "\(appALabel.text)"
            startTimer()
        }
    }

/*
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
*/
 
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
