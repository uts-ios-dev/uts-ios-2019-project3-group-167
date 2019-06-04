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
    var dataManager = DataManager()
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderBtn.imageView?.contentMode = .scaleAspectFit
        reminderBtn.imageEdgeInsets = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)

        if let flightDetails = flight {
            let fromDate = DateUtils.toDate(flightDetails.fromDate)
            let toDate = DateUtils.toDate(flightDetails.toDate)
            
            dateLabel.text = "\(DateUtils.toDateString(fromDate!))"
            flightNumberLabel.text = flightDetails.flightNumber
            originToDestinationLabel.text = "\(flightDetails.origin) to \(flightDetails.destination)"
            timeLabel.text = "\(DateUtils.toTimeString(fromDate!)) - \(DateUtils.toTimeString(toDate!))"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.destination is FlightSearchViewController {
            guard let viewController = segue.destination as? FlightSearchViewController else {
                return
            }
            
            viewController.index = index
        }
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        checklists.append(Checklist(name: "", done: false))
        tableView.reloadData()
    }

    @IBAction func saveItinerary(_ sender: Any) {
        var itineraries: [Itinerary] = []
        do {
            itineraries = try dataManager.loadItinerary()
        }
        catch {
            print("Cannot load itineraries")
        }

        if let itineraryIndex = index {
            itineraries[itineraryIndex] = Itinerary(checkList: checklists, flight: flight!, reminder: itineraries[itineraryIndex].reminder)
        } else {
            let itinerary = Itinerary(checkList: checklists, flight: flight!, reminder: 5)
            itineraries.append(itinerary)
        }
        
        
        do {
            try dataManager.saveItinerary(itineraries)
        } catch {
            print("Data not saved")
        }
        
        self.navigationController?.popToRootViewController(animated: true);
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

