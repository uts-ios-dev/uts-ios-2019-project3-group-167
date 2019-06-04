//
//  ItemCell.swift
//  QuickFlight
//
//  Created by Kevin  on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

protocol ChangeChecklistButton {
    func changeChecklistButton(done: Bool, index: Int)
}

/// Custom cell for checklist display
class ItemCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var itemCheckbox: UIButton!
    @IBOutlet weak var itemTextfield: UITextField!
    
    var checklistButtonDelegate: ChangeChecklistButton?
    var checklists: [Checklist]?
    var indexP: Int?
    
    /// Toggles checklist icon to checked and not checked
    @IBAction func checkboxAction(_ sender: UIButton) {
        if checklists![indexP!].done {
            checklistButtonDelegate?.changeChecklistButton(done: false, index: indexP!)
        } else {
            checklistButtonDelegate?.changeChecklistButton(done: true, index: indexP!)
        }
    }
    
    /// Saves item name
    @IBAction func itemTextfieldAction(_ sender: UITextField) {
        checklists![indexP!].name = itemTextfield.text!
    }
}
