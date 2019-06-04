//
//  HomeViewController.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit

/// Controller for the Home Screen
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var itinerariesTable: UITableView!
    
    var dataManager = DataManager()
    var itineraries: [Itinerary] = []
    
    /// Delegates and assigns data source for itineraries table
    override func viewDidLoad() {
        super.viewDidLoad()

        itinerariesTable.dataSource = self
        itinerariesTable.delegate = self
    }
    
    /// Loads itineraries list and reloads displayed table data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            itineraries = try dataManager.loadItinerary()
        } catch {
            print("Load itinerary error")
        }
        
        itinerariesTable.reloadData()
    }
    
    /// Passes itinerary data when navigating to FlightDetailsViewController
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
            viewController.index = indexPath.row
        }
    }
    
    /// Returns number of rows for itineraries table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itineraries.count
    }
    
    /// Sets displayed texts in itineraries table cells according to the itinerary data
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
    
    /// Returns itineraries table cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    /// Displays delete alert on delete swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            createDeleteAlert(title: "Delete Confirmation", message: "Do you want to delete this itinerary?", indexPath: indexPath, tableView: tableView)
        }
    }
    
    /// Creates alert for deleting itinerary
    ///
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Message to be displayed in the delete alert
    ///   - indexPath: Index of itinerary to be removed
    ///   - tableView: Itinerary table UI
    func createDeleteAlert(title: String, message: String, indexPath: IndexPath, tableView: UITableView) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.itineraries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try self.dataManager.saveItinerary(self.itineraries)
            }
            catch {
                print("Itineraries are not saved")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
