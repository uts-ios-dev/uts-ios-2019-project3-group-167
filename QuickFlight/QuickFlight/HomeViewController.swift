//
//  HomeViewController.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var itinerariesTable: UITableView!
    
    var itineraries: [Itinerary] = []
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            itineraries = try dataManager.loadItinerary()
        } catch {
            print("error")
        }
        itinerariesTable.dataSource = self
        itinerariesTable.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.destination is FlightDetailsViewController {
            guard let viewController = segue.destination as? FlightDetailsViewController,
                let selectedFlightCell = sender as? UITableViewCell,
                let indexPath = itinerariesTable.indexPath(for: selectedFlightCell) else {
                    return
            }
            
            let selectedItinerary = itineraries[indexPath.row]
            viewController.flight = selectedItinerary.flight
            viewController.itinerary = selectedItinerary
            viewController.itineraries = itineraries
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itineraries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itineraryCell", for: indexPath)
        let itinerary = itineraries[indexPath.row]
        
        let destinationAndOriginLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let flightNumberLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let fromDateLabel: UILabel = cell.viewWithTag(3) as! UILabel
        let timeLabel: UILabel = cell.viewWithTag(4) as! UILabel
        let reminderLabel: UILabel = cell.viewWithTag(5) as! UILabel
        
        destinationAndOriginLabel.text = "\(itinerary.flight.origin) to \(itinerary.flight.destination)"
        flightNumberLabel.text = itinerary.flight.flightNumber
        
        let fromDate = DateUtils.toDate(itinerary.flight.fromDate)
        let toDate = DateUtils.toDate(itinerary.flight.toDate)
        fromDateLabel.text = DateUtils.toDateString(fromDate!)
        timeLabel.text = "\(DateUtils.toTimeString(fromDate!)) - \(DateUtils.toTimeString(toDate!))"
        reminderLabel.text = "Reminder \(itinerary.reminder) hour(s) prior"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
