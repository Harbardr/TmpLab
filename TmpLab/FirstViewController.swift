//
//  FirstViewController.swift
//  TmpLab
//
//  Created by Julien FERNANDEZ on 21/10/2016.
//  Copyright © 2016 Julien FERNANDEZ. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var _timer:Timer?

    @IBOutlet weak var ui_backGround: UIImageView!
    
    @IBOutlet weak var ui_tmpLogo: UIImageView!
    
    @IBOutlet weak var ui_onAirImage: UIImageView!
    
    @IBAction func ui_refresh() {
        tmpResidence()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        tmpResidence()
    }
    
    
    func scheduleNewTimer() {
        if let existingTimer:Timer = _timer {
            existingTimer.invalidate()
        }
        let interval = UserDefaults.standard.float(forKey: OptionsViewController.DELAY_OPTION)
        print("New timer launched")
        _timer = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(FirstViewController.tmpResidence), userInfo: nil, repeats: false)
    }
    
    func tmpResidence() {
        
        let myURLString = "http://mptwatch.tmplab.org/?action=get&key=foo&format=boolean"
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            guard let myURL = URL(string: myURLString) else {
                print("Error: \(myURLString) doesn't seem to be a valid URL")
                return
            }
            
            do {
                let myHTMLString:String! = try String(contentsOf: myURL, encoding: .ascii)
                
                if myHTMLString == "1" {
                    print("ON AIR")
                    ui_onAirImage.image = UIImage(named: "bulbOn")
                } else {
                    print("OFF")
                    ui_onAirImage.image = UIImage(named: "bulbOff")
                }
            } catch let error {
                print("Error: \(error)")
            }
            
        } else {
            print("Internet connection FAILED")
            
            ui_onAirImage.image = UIImage(named: "bulbOffNetwork")
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        
        scheduleNewTimer()
    }

}

