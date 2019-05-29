//
//  Flight.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation


class Flight: Codable {
    
    var origin : String
    var destination : String
    var flightNumber : String
    var fromDate: Date
    var toDate: Date
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flightNumber"
        case origin = "origin"
        case destination = "destination"
        case fromDate = "fromDate"
        case toDate = "toDate"
    }
    
    init(origin : String, destination : String, flightNumber : String, fromDate : Date, toDate: Date) {
        self.origin = origin
        self.destination = destination
        self.flightNumber = flightNumber
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)!
        origin = try values.decodeIfPresent(String.self, forKey: .origin)!
        destination = try values.decodeIfPresent(String.self, forKey: .destination)!
        fromDate = DateUtils.toDate(try values.decodeIfPresent(String.self, forKey: .fromDate)!)!
        toDate = DateUtils.toDate(try values.decodeIfPresent(String.self, forKey: .toDate)!)!
    }
}
