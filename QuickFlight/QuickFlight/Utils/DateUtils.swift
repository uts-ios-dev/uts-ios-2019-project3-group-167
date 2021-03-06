//
//  DateUtils.swift
//  QuickFlight
//
//  Created by Jessica Wiradinata on 24/5/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

class DateUtils {
    
    /// Converts String to a Date object
    ///
    /// - Parameter dateString: String contining date to be converted
    /// - Returns: Date object converted from string
    static func toDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: dateString)
    }
    
    /// Converts Date object to a String with date only format
    ///
    /// - Parameter date: Date object to be converted
    /// - Returns: String converted from the provided Date object
    static func toDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    /// Converts Date object to a String with date and time format
    ///
    /// - Parameter date: Date object to be converted
    /// - Returns: String converted from the provided Date object
    static func toDateTimeString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    /// Converts Date object to a String with time only format
    ///
    /// - Parameter date: Date object to be converted
    /// - Returns: String converted from the provided Date object
    static func toTimeString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

