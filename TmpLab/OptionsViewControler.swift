//
//  OptionsViewControler.swift
//  TmpLab
//
//  Created by Julien FERNANDEZ on 22/10/2016.
//  Copyright © 2016 Julien FERNANDEZ. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    static let DELAY_OPTION = "DELAY_OPTION"
    
    @IBOutlet weak var ui_delaySlider: UISlider!
    @IBOutlet weak var ui_labelSlider: UILabel!
    
    func updateSliderLabel(withSlider slider:UISlider) {
        ui_labelSlider.text = "Refresh : \(String(format: "%.f", slider.value/60)) m"
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
        let userDefaults = UserDefaults.standard
        ui_delaySlider.value = userDefaults.float(forKey: OptionsViewController.DELAY_OPTION)
        updateSliderLabel(withSlider: ui_delaySlider)
    }
    
    @IBAction func dismissOptions(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func delaySliderValueChanged(_ sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey: OptionsViewController.DELAY_OPTION)
        updateSliderLabel(withSlider: sender)
    }
}
