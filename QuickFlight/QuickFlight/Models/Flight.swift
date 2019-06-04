//
//  Flight.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation


/// Model for flight data
class Flight: Codable {
    
    static let apiEndpoint = "http://demo7895779.mockable.io/quickflights/flights"
    
    var origin : String
    var destination : String
    var flightNumber : String
    var fromDate: String
    var toDate: String
    
    /// Property keys for decoding from JSON
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flightNumber"
        case origin = "origin"
        case destination = "destination"
        case fromDate = "fromDate"
        case toDate = "toDate"
    }
    
    /// Initialises Flight model based on the provided data
    ///
    /// - Parameters:
    ///   - origin: flight origin city
    ///   - destination: flight destination city
    ///   - flightNumber: flight code
    ///   - fromDate: flight departure date
    ///   - toDate: flight arrival date
    init(origin : String, destination : String, flightNumber : String, fromDate : String, toDate: String) {
        self.origin = origin
        self.destination = destination
        self.flightNumber = flightNumber
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    /// Initialises Flight by decoding from JSON data
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)!
        origin = try values.decodeIfPresent(String.self, forKey: .origin)!
        destination = try values.decodeIfPresent(String.self, forKey: .destination)!
        fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)!
        toDate = try values.decodeIfPresent(String.self, forKey: .toDate)!
    }
}
