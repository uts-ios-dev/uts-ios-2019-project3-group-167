//
//  ViewController.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChangeButton, CreateItem {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var originToDestinationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var flight: Flight?
    var items: [Item] = [Item(itemName: "Banana")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flightDetails = flight {
            dateLabel.text = DateUtils.toDateString(flightDetails.fromDate)
            flightNumberLabel.text = flightDetails.flightNumber
            originToDestinationLabel.text = "\(flightDetails.origin) to \(flightDetails.destination)"
            timeLabel.text = "\(DateUtils.toTimeString(flightDetails.fromDate)) - \(DateUtils.toTimeString(flightDetails.toDate))"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.itemTextfield.text = items[indexPath.row].itemName
        
        if items[indexPath.row].checked {
            cell.itemCheckbox.setBackgroundImage(UIImage(named: "checkboxFilled"), for: .normal)
        } else {
            cell.itemCheckbox.setBackgroundImage(UIImage(named: "checkboxOutline"), for: .normal)
        }
        
        if (indexPath.row == 0) {
            if (items[indexPath.row].itemName != "") {
                items.append(Item(itemName: ""))
            }
        }
        
        cell.changeButtonDelegate = self
        cell.createItemDelegate = self
        cell.indexP = indexPath.row
        cell.items = items
        
        return cell
    }
    
    func changeButton(checked: Bool, index: Int) {
        items[index].checked = checked
        tableView.reloadData()
    }
    
    func createItem(itemName: String, index: Int) {
        items[index].itemName = itemName
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

class Item {
    var itemName: String = ""
    var checked: Bool = false
    
    convenience init(itemName: String) {
        self.init()
        self.itemName = itemName
    }
}

