//
//  SettingsViewController.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var optionTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        infoLabel.text = String(Int(sender.value))
    }

    @IBAction func saveSettings(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        //configuring the notification content
        let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "You have an upcoming flight for next week"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: ((didAllow, error)))
    }
   
    
}
