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
 DONE Change switch into For..In loop in upDateClock for (applic, appTime) in appDict
 DONE in updateClock, allow for variable number of cases
            experiment: replace IBOutlets with subviews
 DONE multiple buttons, one timer
 DONE Starting any app stops timer of another app
        inactivity causes stop; 
            different classes of app hae different inactivity threshholds
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
    
    var appDict: [String: Int ] = [:]
    var appName = "none"
    var appRunning = "none"

    var appInactivityLimit = 90
    var appSeconds = 0
    var timer = Timer()
    var timerIsOn = false
   
    func loadDictItem(_ item: String) {
        appDict[(item)] = 0
    }
    
    func updateClock() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        clockViewLabel.text = "\(formatter.string(from: clock.currentTime as Date))"
//  this loop continuously displays total times used.
                if appDict.values.isEmpty {
                }
                    else {
                    var labelCnt = 0
                    let sortedKeys: Array = (appDict as NSDictionary).keysSortedByValue(comparator: { ($1 as! NSNumber ).compare($0 as! NSNumber ) })
//                    let sortedKeys:Array = (appDict as NSDictionary).keysSortedByValueUsingSelector(#selector(NSNumber.compare(_:)))
                        for applic in sortedKeys {
                            let appTime = appDict["\(applic)"]
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
        appSeconds += 1
        timerViewLabel.text = "\(appSeconds)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateClock)), userInfo: nil, repeats: true)
    }
        
/*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.updateClock), name: UIApplicationWillEnterForegroundNotification, object: nil)
            }
*/

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

    
    @IBAction func refreshButton(_ sender: AnyObject) {
        //        timer.invalidate()
        appSeconds = 0
        timerViewLabel.text = "\(appSeconds)"
    }

    
    @IBAction func stopButton(_ sender: AnyObject) {
        if timerIsOn == false {
            errCodeViewLabel.text = "Timer is not running"
        }
        if timerIsOn {
            var totalTimeUsed = appDict[appName]!
            print("stopButton => appName: \(appName) Total: \(appDict[appName]!)")
            totalTimeUsed = totalTimeUsed + appSeconds
            print("stopButton => total + timer: \(totalTimeUsed)")
            appDict[appName] = totalTimeUsed
            print("stopButton => appName: \(appName) Total: \(appDict[appName]!)")
            print("stopButton => \(appName) Timer stopped.")
            timer.invalidate()
            appSeconds = 0
            timerViewLabel.text = "\(appSeconds)"
            appName = "none"
            appRunning = "none"
            timerIsOn = false
        }
    }
    
    func stopFunc() {
        if timerIsOn {
            var totalTimeUsed = appDict[appName]!
            print("stopFunc => appName: \(appName) Total: \(appDict[appName]!)")
            totalTimeUsed = totalTimeUsed + appSeconds
            print("stopFunc => total + timer: \(totalTimeUsed)")
            appDict[appName] = totalTimeUsed
            print("stopFunc => appName: \(appName) Total: \(appDict[appName]!)")
            print("stopFunc => \(appName) Timer stopped.")
            appDict[appName] = totalTimeUsed
            timer.invalidate()
            appSeconds = 0
            timerViewLabel.text = "\(appSeconds)"
            appName = "none"
            appRunning = "none"
            timerIsOn = false
        }
    }
    
    func startTimer () {
        print("startTimer=> Begin ...")
        print("    timerIsOn = \(timerIsOn)")
        print("      appName = \(appName)")
        print("     appRunning = \(appRunning)")
        if timerIsOn && appName != appRunning {
            print("startTimer=> timerIsOn but \(appName) is not \(appRunning) ..!. calling stopFunc ...")
            stopFunc()
        }
        if appDict[appName] == nil {
            print("startTimer => ... App named \(appName) Not in Dict, calling loadDict ...")
            loadDictItem(appName)
        }
        timerViewLabel.text = "0"
        appSeconds = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        appRunning = appName
        timerIsOn = true
        print("startTimer => End ...")
        print("   timerIsOn = \(timerIsOn)")
        print("   appName = \(appName)")
        print("  appRunning = \(appRunning)")
    }
    
    
/*
     ++  Starting any app stops timer of another app
     +  Enable selection of the relevant table entry within one function
     +  Enable appName:randomNum ... randomNum:timeUsed ... report by appName->timeUsed
     collect appName from object selected
     determine if appName is in list of tracked apps
     and if not, load it for tracking
 */
    

    @IBAction func itemAStartButton(_ sender: AnyObject) {
        if appName != "A" {
            stopFunc()
            appName = "A"
            startTimer()
        }
    }

 
    @IBAction func itemBStartButton(_ sender: AnyObject) {
        if appName != "B" {
                stopFunc()
            appName = "B"
            startTimer()
        }
    }

    @IBAction func itemCStartButton(_ sender: AnyObject) {
        if appName != "C" {
                stopFunc()
            appName = "C"
            startTimer()
        }
    }
    
    @IBAction func itemDStartButton(_ sender: AnyObject) {
        if appName != "D" {
                stopFunc()
            appName = "D"
            startTimer()
        }
    }
    
    
    @IBAction func itemEStartButton(_ sender: AnyObject) {
        if appName != "E" {
                stopFunc()
            appName = "E"
             startTimer()
        }
    }

 
    @IBAction func itemFStartButton(_ sender: AnyObject) {
        if appName != "F" {
                stopFunc()
            appName = "F"
            startTimer()
        }
    }
}
