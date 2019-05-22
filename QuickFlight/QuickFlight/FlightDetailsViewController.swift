//
//  ViewController.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [Item] = [Item(itemName: "Banana")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        items.append(Item(itemName: "apple"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.itemLabel.text = items[indexPath.row].itemName
        
        return cell
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

