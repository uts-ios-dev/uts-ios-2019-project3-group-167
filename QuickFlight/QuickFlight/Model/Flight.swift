//
//  Flight.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation


class Flight{
    var origin : String
    var destination : String
    var flightNumber : String
    var date : Date
    
    init(origin : String, destination : String, flightNumber : String, date : Date) {
        self.origin = origin
        self.destination = destination
        self.flightNumber = flightNumber
        self.date = date
    }
    
}
