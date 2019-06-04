//
//  ViewController.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import UIKit
import UserNotifications

/// This is a controller mainly for displaying flight details and itinerary to be prepared before flight
/// date. This controller also serves a sendNotification functionality after pressing Save button.
class FlightDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ChangeChecklistButton, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var originToDestinationLabel: UILabel!
    @IBOutlet weak var reminderBtn: UIButton!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var checklists: [Checklist] = []
    var dataManager = DataManager()
    var flight: Flight?
    var index: Int?
    var itinerary: Itinerary?
    var itineraries: [Itinerary] = []
    var reminder: Int?
    
    /// Sets flight details when the view is loaded
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
    
    /// Fetches itineraries from localdata and sets reminder value
    override func viewWillAppear(_ animated: Bool) {
        do {
            itineraries = try dataManager.loadItinerary()
        }
        catch {
            print("Cannot load itineraries")
        }
        
        if let itineraryIndex = index {
            checklists = itineraries[itineraryIndex].checklists
        } else {
            checklists = [Checklist(name: "", done: false)]
        }
        
        guard let itineraryIndex = index else {
            return
        }
        
        if let reminderValue = reminder {
            itineraries[itineraryIndex].reminder = reminderValue
        }
        
        tableView.reloadData()
        reminderLabel.text = "Reminder \(itineraries[itineraryIndex].reminder) hour(s) prior"
    }
    
    /// Prepare some data to be sent to the next ViewController (FlightSearchViewController).
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.destination is FlightSearchViewController {
            guard let viewController = segue.destination as? FlightSearchViewController else {
                return
            }
            
            viewController.index = index
        }
        
        if segue.destination is SettingsViewController {
            if let viewController = segue.destination as? SettingsViewController {
                viewController.reminder = itinerary?.reminder
            }
        }
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        checklists.append(Checklist(name: "", done: false))
        tableView.reloadData()
    }
    
    /// Saves itinerary to list of itinieraries and sends local notification within
    /// time specified in the flight details.
    @IBAction func saveItinerary(_ sender: Any) {
        if let itineraryIndex = index {
            var newReminder: Int?
            
            if let reminderValue = reminder {
                newReminder = reminderValue
            } else {
                newReminder = itineraries[itineraryIndex].reminder
            }
            
            itineraries[itineraryIndex] = Itinerary(checkList: checklists, flight: flight!, reminder: newReminder!)
        } else {
            var newReminder: Int?
            
            if let reminderValue = reminder {
                newReminder = reminderValue
            } else {
                newReminder = 5
            }
            
            let itinerary = Itinerary(checkList: checklists, flight: flight!, reminder: newReminder!)
            itineraries.append(itinerary)
        }
        
        do {
            try dataManager.saveItinerary(itineraries)
        }
        catch {
            print("Data not saved")
        }
        setNotification()
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    /// Returns row numbers to be populated in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklists.count
    }
    
    /// Returns custom cell inside tableview with checklist and textfield
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
    
    /// Sets delete functionality for each cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.checklists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /// Returns height of the tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    /// Sets checklist done with boolean and reloads data afterwards
    ///
    /// - Parameters:
    ///   - done: checklist for an item
    ///   - index: index of the item
    func changeChecklistButton (done: Bool, index: Int) {
        checklists[index].done = done
        tableView.reloadData()
    }

    /// Dismisses keyboard when a user clicks return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /// Set reminder notifications before flight date and time. The value depends
    /// on the reminder value that a user set (default is 5 hours).
    func setNotification() {
        var departureDate: Date
        var reminderTime: Int

        if let itineraryIndex = index {
            departureDate = DateUtils.toDate(itineraries[itineraryIndex].flight.fromDate)!
            reminderTime = itineraries[itineraryIndex].reminder
        } else {
            departureDate = DateUtils.toDate((flight?.fromDate)!)!
            if let reminderValue = reminder {
                reminderTime = reminderValue
            } else {
                reminderTime = 5
            }
        }

        let calendar = Calendar.current
        let newdate = calendar.date(byAdding: .hour, value: 0 - reminderTime, to: departureDate)
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: newdate!)

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "You have an upcoming flight at \(DateUtils.toDateTimeString(departureDate))"
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

