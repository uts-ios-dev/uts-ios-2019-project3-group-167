//
//  Itinerary.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

// This is a class to provide Itenerary model which inherits from Codable
class Itinerary: Codable {
    
    var checklists : [Checklist] = []
    var flight : Flight
    var reminder : Int
    
    enum CodingKeys: String, CodingKey {
        case checklists = "checklists"
        case flight = "flight"
        case reminder = "reminder"
    }
    
    /// Initialise the itinerary model based on checklist class, flight class and the reminder value.
    ///
    /// - Parameters:
    ///   - checkList: the checklist class which contains string name and boolean don
    ///   - flight: the flight class which contains the the information of flight
    ///   - reminder: the reminder which is the value for set time to send the notification
    init(checkList: [Checklist], flight: Flight, reminder: Int) {
        self.checklists = checkList
        self.flight = flight
        self.reminder = reminder
    }
    
    /// Initialises Itinerary by decoding from JSON Data
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        checklists = try values.decodeIfPresent([Checklist].self, forKey: .checklists)!
        flight = try values.decodeIfPresent(Flight.self, forKey: .flight)!
        reminder = try values.decodeIfPresent(Int.self, forKey: .reminder)!
    }
}
