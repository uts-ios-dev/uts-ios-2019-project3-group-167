//
//  ItemCell.swift
//  QuickFlight
//
//  Created by Kevin  on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

protocol ChangeButton {
    func changeButton(checked: Bool, index: Int)
}

protocol CreateItem {
    func createItem(itemName: String, index: Int)
}

class ItemCell: UITableViewCell {
    @IBOutlet weak var itemCheckbox: UIButton!
    @IBOutlet weak var itemTextfield: UITextField!
    
    var changeButtonDelegate: ChangeButton?
    var createItemDelegate: CreateItem?
    var indexP: Int?
    var items: [Item]?
    
    @IBAction func checkboxAction(_ sender: UIButton) {
        if items![indexP!].checked {
            print("false")
            changeButtonDelegate?.changeButton(checked: false, index: indexP!)
        } else {
            changeButtonDelegate?.changeButton(checked: true, index: indexP!)
        }
    }
    
    @IBAction func itemTextfieldAction(_ sender: UITextField) {
        print(itemTextfield.text!)
        // This section will save the data to a new array when database is connected.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        itemTextfield.resignFirstResponder()
    }
}
