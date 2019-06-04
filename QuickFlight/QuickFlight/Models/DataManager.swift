//
//  DataManager.swift
//  QuickFlight
//
//  Created by Kevin  on 2/6/19.
//  Copyright © 2019 Jessica Wiradinata. All rights reserved.
//

import Foundation

class DataManager: Codable {
    
    let itineraryJSONUrl: URL
    
    enum DataError: Error {
        case dataNotReadable
        case dataNotSaveable
    }
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        itineraryJSONUrl = documentsDirectory.appendingPathComponent("itineraries").appendingPathExtension("json")
    }
    

    /// Overwrites data to the archive (JSON File)
    ///
    /// - Parameters:
    ///   - data: data to be overwritten
    ///   - archive: url where data is saved
    /// - Throws: DataError.dataNotSaveable
    func writeData(_ data: Data, to archive: URL) throws {
        do {
            try data.write(to: archive, options: .noFileProtection)
        }
        catch {
            throw DataError.dataNotSaveable
        }
    }

    /// Loads data from the archive (JSON File)
    ///
    /// - Parameter archive: url where data is saved
    /// - Returns: Data to be loaded
    /// - Throws: DataError.dataNotReadable
    func readData(from archive: URL) throws -> Data {
        do {
            if let data = try? Data(contentsOf: archive) {
                return data
            }
        }
        throw DataError.dataNotReadable
    }
    
    /// Save new itineraries to the itineraries.json
    ///
    /// - Parameter itineraries: list of itineraries
    /// - Throws: DataError.dataNotSaveable
    func saveItinerary(_ itineraries: [Itinerary]) throws {
        let itineraryJSON = try JSONEncoder().encode(itineraries)
        try writeData(itineraryJSON, to: itineraryJSONUrl)
    }
    
    /// Load the saved itineraries from itineraries.json
    ///
    /// - Returns: List of itineraries that was saved before
    /// - Throws: DataError.dataNotReadable
    func loadItinerary() throws -> [Itinerary] {
        let data = try readData(from: itineraryJSONUrl)
        if let itineraries = try? JSONDecoder().decode([Itinerary].self, from: data) {
            return itineraries
        }
        throw DataError.dataNotReadable
    }
}
