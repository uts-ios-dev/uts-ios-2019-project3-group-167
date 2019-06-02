//
//  Checklist.swift
//  QuickFlight
//
//  Created by Yanto Yanto on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

class Checklist: Codable {
    var name : String = ""
    var done : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case done = "done"
    }
    
    init(name : String, done : Bool){
        self.name = name
        self.done = done
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        done = try values.decodeIfPresent(Bool.self, forKey: .done)!
    }
}
