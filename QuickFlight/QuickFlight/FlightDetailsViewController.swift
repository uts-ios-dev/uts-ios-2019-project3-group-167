//
//  ViewController.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

class FlightDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChangeChecklistButton {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var originToDestinationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var reminderBtn: UIButton!
    
    var flight: Flight?
    var itinerary: Itinerary?
    var itineraries: [Itinerary]?
    var checklists: [Checklist] = [Checklist(name: "Apple", done: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderBtn.imageView?.contentMode = .scaleAspectFit
        reminderBtn.imageEdgeInsets = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)

        if let flightDetails = flight {
            dateLabel.text = DateUtils.toDateString(flightDetails.fromDate)
            flightNumberLabel.text = flightDetails.flightNumber
            originToDestinationLabel.text = "\(flightDetails.origin) to \(flightDetails.destination)"
            timeLabel.text = "\(DateUtils.toTimeString(flightDetails.fromDate)) - \(DateUtils.toTimeString(flightDetails.toDate))"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            
        }
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        checklists.append(Checklist(name: "", done: false))
        tableView.reloadData()
    }

    @IBAction func saveItinerary(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.itemTextfield.text = checklists[indexPath.row].name
        
        if checklists[indexPath.row].done {
            cell.itemCheckbox.setBackgroundImage(UIImage(named: "checkboxFilled"), for: .normal)
        } else {
            cell.itemCheckbox.setBackgroundImage(UIImage(named: "checkboxOutline"), for: .normal)
        }

        cell.checklistButtonDelegate = self
        cell.indexP = indexPath.row
        cell.checklists = checklists
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.checklists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func changeChecklistButton (done: Bool, index: Int) {
        checklists[index].done = done
        tableView.reloadData()
    }
}

