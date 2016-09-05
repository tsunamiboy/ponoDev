//
//  ViewController.swift
//  Pono v. 0.01
//
//  Created by David Blake on 8/17/16.
//  Copyright © 2016 Sea Turtle Dreams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let clock = Clock()
    
    @IBOutlet weak var clockViewLabel: UILabel!
    
    
    @IBOutlet weak var itemATimeUsedLabel: UILabel!
    @IBOutlet weak var itemBTimeUsedLabel: UILabel!
    @IBOutlet weak var itemCTimeUsedLabel: UILabel!

    @IBOutlet weak var timerViewLabel: UILabel!
//    @IBOutlet weak var itemATimerViewLabel: UILabel!
//    @IBOutlet weak var itemBTimerViewLabel: UILabel!
//    @IBOutlet weak var itemCTimerViewLabel: UILabel!
    
    @IBOutlet weak var errCodeViewLabel: UILabel!
    
//    var time = NSDate()
    
    var clockTimer: NSTimer?
    
//   replace elapsedTime: Int with dict [String(appl): Int(timeUsed)]
    var itemDict: [String: Int ] = [:]
    var appName = "none"
    var elapsedTime = 0
    
    var seconds = 0
    var timer = NSTimer()
    var timerIsOn = false
   
    func loadDictItem(item: String) {
        itemDict[(item)] = 0
    }
    
    func updateClock() {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        clockViewLabel.text = "\(formatter.stringFromDate(clock.currentTime))"
    }
/*
     Compress timer ladel from 3 to 1
  */
    func updateTimer() {
        seconds += 1
        timerViewLabel.text = "\(seconds)"
//        switch appName {
//        case "A": itemATimerViewLabel.text = "\(seconds)"
//        case "B": itemBTimerViewLabel.text = "\(seconds)"
//        case "C": itemCTimerViewLabel.text = "\(seconds)"
//        default:             errCodeViewLabel.text = "Bad"
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        clockTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateClock)), userInfo: nil, repeats: true)
        
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
    
    
    override func viewWillAppear(animated: Bool) {
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
    
    @IBAction func refreshButton(sender: AnyObject) {
        //        timer.invalidate()
        seconds = 0
        timerViewLabel.text = "\(seconds)"
//        itemATimerViewLabel.text = "\(seconds)"
//        itemBTimerViewLabel.text = "\(seconds)"
//        itemCTimerViewLabel.text = "\(seconds)"
        //        timerIsOn = false
    }
    /*
     Compress 3 stop buttons to 1
     Compress 3 timer labels to 1
     Display time totals of all apps
     */
    
    @IBAction func stopButton(sender: AnyObject) {
        if timerIsOn == false {
            errCodeViewLabel.text = "Timer is not running"
        }
        if timerIsOn {
            var totalTimeUsed = itemDict[appName]!
//            var totalTimeUsed = itemDict["A"]!
            //            print(totalTimeUsed)
            totalTimeUsed = totalTimeUsed + seconds
            //            print(totalTimeUsed)
            itemDict[appName] = totalTimeUsed
//            itemDict["A"] = totalTimeUsed
            //            print(itemDict["A"])
            switch appName {
            case "A": itemATimeUsedLabel.text = "\(totalTimeUsed)"
            case "B": itemBTimeUsedLabel.text = "\(totalTimeUsed)"
            case "C": itemCTimeUsedLabel.text = "\(totalTimeUsed)"
            default:
                errCodeViewLabel.text = "appName \(appName) Total Time did not resolve"
            }
            
            itemATimeUsedLabel.text = "\(totalTimeUsed)"
            timer.invalidate()
            timerIsOn = false
        }
    }
    
 /*
   Compress start functions so that the relevant table entry is selected within one function
     Enable selection of appName value from A Dictionary
     Enable radio button selection
     Enable creation of the Dictionary key by input from text
        Use random generation of value
     Enable creation of the Dictionary value by drag and Drop of objects
     Enable collection of the app... by detecting object id
 */
    
    @IBAction func itemAStartButton(sender: AnyObject) {
        if itemDict["A"] == nil {
            loadDictItem("A")
        }
        if timerIsOn == false {
            appName = "A"
            timerViewLabel.text = "0"
            seconds = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func itemBStartButton(sender: AnyObject) {
        if itemDict["B"] == nil {
            loadDictItem("B")
        }
        if timerIsOn == false {
            appName = "B"
            timerViewLabel.text = "0"
            seconds = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func itemCStartButton(sender: AnyObject) {
        if itemDict["C"] == nil {
            loadDictItem("C")
        }
        if timerIsOn == false {
            appName = "C"
            timerViewLabel.text = "0"
            seconds = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }


/*
    @IBAction func stopAButton(sender: AnyObject) {
        if timerIsOn {
        var totalTimeUsed = itemDict["A"]!
//            print(totalTimeUsed)
        totalTimeUsed = totalTimeUsed + seconds
//            print(totalTimeUsed)
        itemDict["A"] = totalTimeUsed
//            print(itemDict["A"])
        itemATimeUsedLabel.text = "\(totalTimeUsed)"
        timer.invalidate()
        timerIsOn = false
        }
    }
    
    @IBAction func stopBButton(sender: AnyObject) {
        if timerIsOn {
            var totalTimeUsed = itemDict["B"]!
            //            print(totalTimeUsed)
            totalTimeUsed = totalTimeUsed + seconds
            //            print(totalTimeUsed)
            itemDict["B"] = totalTimeUsed
            //            print(itemDict["B"])
            itemBTimeUsedLabel.text = "\(totalTimeUsed)"
            timer.invalidate()
            timerIsOn = false
        }
    }
    
    @IBAction func stopCButton(sender: AnyObject) {
        if timerIsOn {
            var totalTimeUsed = itemDict["C"]!
            //            print(totalTimeUsed)
            totalTimeUsed = totalTimeUsed + seconds
            //            print(totalTimeUsed)
            itemDict["C"] = totalTimeUsed
            //            print(itemDict["C"])
            itemCTimeUsedLabel.text = "\(totalTimeUsed)"
            timer.invalidate()
            timerIsOn = false
        }
    }
 */

}

