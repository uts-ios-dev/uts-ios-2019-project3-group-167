//
//  Itinerary.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

class Itinerary{
    var checkList : [Checklist] = []
    var flight : Flight
    var reminder : Int
    
    init(checkList : [Checklist], flight : Flight, reminder : Int) {
        self.checkList = checkList
        self.flight = flight
        self.reminder = reminder
    }
}
