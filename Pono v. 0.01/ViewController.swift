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

    @IBOutlet weak var itemATimerViewLabel: UILabel!
    @IBOutlet weak var itemBTimerViewLabel: UILabel!
    @IBOutlet weak var itemCTimerViewLabel: UILabel!
    
    @IBOutlet weak var errorCodeViewLabel: UILabel!
    
//    var time = NSDate()
    
    var clockTimer: NSTimer?
    
//   replace elapsedTime: Int with dict [String(appl): Int(timeUsed)]
    var itemDict: [String: Int ] = [:]
    var AppName = "none"
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

    func updateTimer() {
        seconds += 1
        switch AppName {
        case "A": itemATimerViewLabel.text = "\(seconds)"
        case "B": itemBTimerViewLabel.text = "\(seconds)"
        case "C": itemCTimerViewLabel.text = "\(seconds)"
        default:
            errorCodeViewLabel.text = "Bad"
        }
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
    
    
    @IBAction func itemAStartButton(sender: AnyObject) {
        if itemDict["A"] == nil {
            loadDictItem("A")
        }
        if timerIsOn == false {
            AppName = "A"
            itemATimerViewLabel.text = "0"
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
            AppName = "B"
            itemBTimerViewLabel.text = "0"
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
            AppName = "C"
            itemCTimerViewLabel.text = "0"
            seconds = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }

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
    
    @IBAction func refreshButton(sender: AnyObject) {
//        timer.invalidate()
        seconds = 0
        itemATimerViewLabel.text = "\(seconds)"
        itemBTimerViewLabel.text = "\(seconds)"
        itemCTimerViewLabel.text = "\(seconds)"
//        timerIsOn = false
    }
    


}

