//
//  Itinerary.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

class Itinerary: Codable {
    
    var checklists : [Checklist] = []
    var flight : Flight
    var reminder : Int
    
    enum CodingKeys: String, CodingKey {
        case checklists = "checklists"
        case flight = "flight"
        case reminder = "reminder"
    }
    
    init(checkList : [Checklist], flight : Flight, reminder : Int) {
        self.checklists = checkList
        self.flight = flight
        self.reminder = reminder
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        checklists = try values.decodeIfPresent([Checklist].self, forKey: .checklists)!
        flight = try values.decodeIfPresent(Flight.self, forKey: .flight)!
        reminder = try values.decodeIfPresent(Int.self, forKey: .reminder)!
    }
}
