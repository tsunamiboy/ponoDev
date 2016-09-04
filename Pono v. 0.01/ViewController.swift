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
    
    
    @IBOutlet weak var timerViewLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!

    
//    var time = NSDate()
    
    var clockTimer: NSTimer?
    
//   replace elapsedTime: Int with dict [String(appl): Int(timeUsed)]
    var itemDict: [String: Int ] = [:]
    var elapsedTime = 0
    
    var seconds = 0
    var timer = NSTimer()
    var timerIsOn = false
   
    func loadDictItem(item: String) {
        itemDict[(item)] = 0
    }
    
    func updateTimer() {
        seconds += 1
        timerViewLabel.text = "\(seconds)"
    }
    
    func updateClock() {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        clockViewLabel.text = "\(formatter.stringFromDate(clock.currentTime))"
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
    
    
    @IBAction func startButton(sender: AnyObject) {
//        if timerIsOn == false {
////            timerViewLabel.text = "0"
//            elapsedTime = 0
//            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
//            timerIsOn = true
//        }
    }
    
    @IBAction func itemAStartButton(sender: AnyObject) {
        if itemDict["A"] == nil {
            loadDictItem("A")
        }
        if timerIsOn == false {
            timerViewLabel.text = "0"
            seconds = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }

    @IBAction func stopButton(sender: AnyObject) {
//        
        // save the elapsed time
//        elapsedTime = elapsedTime + seconds
        if timerIsOn {
        var totalTimeUsed = itemDict["A"]!
//            print(totalTimeUsed)
        totalTimeUsed = totalTimeUsed + seconds
//            print(totalTimeUsed)
        itemDict["A"] = totalTimeUsed
//            print(itemDict["A"])
        elapsedTimeLabel.text = "\(totalTimeUsed)"
        timer.invalidate()
        timerIsOn = false
        }
    }
    
    @IBAction func refreshButton(sender: AnyObject) {
//        timer.invalidate()
        seconds = 0
        timerViewLabel.text = "\(seconds)"
//        elapsedTimeLabel.text = "\(seconds)"
//        timerIsOn = false
    }
    


}

