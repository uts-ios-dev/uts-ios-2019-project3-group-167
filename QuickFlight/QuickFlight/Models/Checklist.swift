//
//  Checklist.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

/// This is a class to provide Checklist model
class Checklist: Codable {
    var name : String = ""
    var done : Bool = false
    
    /// Initializes new checklist object
    ///
    /// - Parameters:
    ///   - name: item name
    ///   - done: checklist of the item
    init(name : String, done : Bool){
        self.name = name
        self.done = done
    }
}
