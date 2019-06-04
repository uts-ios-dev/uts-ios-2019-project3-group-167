//
//  FlightSearchViewController.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 20/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Alamofire
import UIKit

class FlightSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var flightResultsTable: UITableView!
    
    var flightResults: [Flight] = []
    var itineraries: [Itinerary]?
    var searchFlightResults: [Flight] = []
    var isFlightSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        flightResultsTable.dataSource = self
        flightResultsTable.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

        fetchFlights()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.destination is FlightDetailsViewController {
            guard let viewController = segue.destination as? FlightDetailsViewController,
                let selectedFlightCell = sender as? UITableViewCell,
                let indexPath = flightResultsTable.indexPath(for: selectedFlightCell) else {
                    return
            }
            
            let selectedFlight = flightResults[indexPath.row]
            viewController.flight = selectedFlight
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFlightSearching {
            return searchFlightResults.count
        }

        return flightResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightResultCell", for: indexPath)

        var flight = flightResults[indexPath.row]
        if isFlightSearching {
            flight = searchFlightResults[indexPath.row]
        }
        
        let destinationAndOriginLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let flightNumberLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let fromDateLabel: UILabel = cell.viewWithTag(3) as! UILabel
        let timeLabel: UILabel = cell.viewWithTag(4) as! UILabel
        
        destinationAndOriginLabel.text = "\(flight.origin) to \(flight.destination)"
        flightNumberLabel.text = flight.flightNumber
        
        let fromDate = DateUtils.toDate(flight.fromDate)
        let toDate = DateUtils.toDate(flight.toDate)
        fromDateLabel.text = DateUtils.toDateString(fromDate!)
        timeLabel.text = "\(DateUtils.toTimeString(fromDate!)) - \(DateUtils.toTimeString(toDate!))"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            isFlightSearching = false
            flightResultsTable.reloadData()
            return
        }

        isFlightSearching = true
        searchFlightResults = flightResults.filter({$0.flightNumber.contains(textToSearch)})
        flightResultsTable.reloadData()
    }

    func fetchFlights() {
        let flightsEndpoint: String = "http://demo7895779.mockable.io/quickflights/flights"
        
        Alamofire.request(flightsEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                do {
                    let jsonDecoder = JSONDecoder()
                    let flightsResponse = try jsonDecoder.decode(Array<Flight>.self, from: response.data!)
                    
                    self.flightResults = flightsResponse
                    self.flightResultsTable.reloadData()
                } catch {
                    print(error)
                }
        }
    }
}
