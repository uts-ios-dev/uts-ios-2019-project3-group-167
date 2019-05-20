//
//  SettingsViewController.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func timeSlider(_ sender: UISlider) {
    }
    @IBOutlet weak var optionPicker: UIPickerView!
    
    //create options
    var list = ["hour(s)", "day(s)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberofComponentsInPickerView(pickerView :UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView :UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(pickerView :UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        self.view.endEditing(true)
        return list[row]
    }
    
    /*func pickerView(pickerView :UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String!{
        self.textBox.text = self.list[row]
        self
    }*/

}
