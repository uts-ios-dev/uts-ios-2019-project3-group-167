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

protocol CreateItem {
    func createItem(itemName: String, index: Int)
}

class ItemCell: UITableViewCell {
    @IBOutlet weak var itemCheckbox: UIButton!
    @IBOutlet weak var itemTextfield: UITextField!
    
    var checklistButtonDelegate: ChangeChecklistButton?
    var createItemDelegate: CreateItem?
    var indexP: Int?
    var checklists: [Checklist]?
    
    @IBAction func checkboxAction(_ sender: UIButton) {
        if checklists![indexP!].done {
            checklistButtonDelegate?.changeChecklistButton(done: false, index: indexP!)
        } else {
            checklistButtonDelegate?.changeChecklistButton(done: true, index: indexP!)
        }
    }
    
    @IBAction func itemTextfieldAction(_ sender: UITextField) {
        // This section will save the data to a new array when database is connected.
        checklists![indexP!].name = itemTextfield.text!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        itemTextfield.resignFirstResponder()
    }
}
