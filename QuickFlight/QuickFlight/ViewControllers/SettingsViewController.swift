//
//  SettingsViewController.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit
import UserNotifications

//This is a controller for handling the reminder setting for sending the notification to the users. It passes the amount of the reminding time from the view.
class SettingsViewController: UIViewController {
   
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reminderStepper: UIStepper!
    
    var reminder: Int?
    
    ///To call the view (UI) when it is executed
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///Sets the text of the label based on stepper and specifies the default reminder value of 5
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let reminderValue = reminder {
            reminderStepper.value = Double(reminderValue)
        } else {
            reminderStepper.value = 5.0
        }
        infoLabel.text = String(Int(reminderStepper.value))
    }
    
    /// Pass the reminder data when navigating to the flight details
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
    
    /// This enables the user to determine the amount of hours by the stepper and shows the value into the specified label
    @IBAction func stepperValueChanged(_ sender: Any) {
        infoLabel.text = String(Int(reminderStepper.value))
    }
    
   
    
   
}
