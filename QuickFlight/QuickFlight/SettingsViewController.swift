//
//  SettingsViewController.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var optionTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        infoLabel.text = String(Int(sender.value))
    }

}
