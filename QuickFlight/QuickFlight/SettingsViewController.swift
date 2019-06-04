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
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reminderStepper: UIStepper!
    
    var reminder: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let reminderValue = reminder {
            reminderStepper.value = Double(reminderValue)
        } else {
            reminderStepper.value = 5.0
        }
        
        infoLabel.text = String(Int(reminderStepper.value))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let viewControllers = self.navigationController?.viewControllers else {
            return
        }
        
        let flightDetailsViewControllerIndex = viewControllers.count - 1
        
        if self.isMovingFromParent {
            if let flightDetailsViewController = viewControllers[flightDetailsViewControllerIndex] as? FlightDetailsViewController {
                flightDetailsViewController.reminder = Int(reminderStepper.value)
            }
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        infoLabel.text = String(Int(reminderStepper.value))
    }
    
    func setNotification() {
        //configuring the notification content
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "You have an upcoming flight for next week"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        //      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: ((didAllow, error)))
    }
}
