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
        case dataNotFound
    }
    
    init() {
        // Gets the document directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // Creates a path to save and load game settings in a json file
        itineraryJSONUrl = documentsDirectory.appendingPathComponent("itineraries").appendingPathExtension("json")
    }
    
    /**
     Overwrites data to the archive (JSON File)
     */
    func writeData(_ data: Data, to archive: URL) throws {
        do {
            try data.write(to: archive, options: .noFileProtection)
        }
        catch {
            throw error
        }
    }
    
    /**
     Loads data from the archive (JSON File)
     */
    func readData(from archive: URL) throws -> Data {
        do {
            if let data = try? Data(contentsOf: archive) {
                print(data)
                return data
            }
        }
        throw DataError.dataNotFound
    }
    
    /**
     Saves game scores to a game-scores.json
     */
    func saveItinerary(_ itineraries: [Itinerary]) throws {
        let itineraryJSON = try JSONEncoder().encode(itineraries)
        try writeData(itineraryJSON, to: itineraryJSONUrl)
    }
    
    func loadItinerary() throws -> [Itinerary] {
        let data = try readData(from: itineraryJSONUrl)
        print("AAAAA \(data)")
        if let itineraries = try? JSONDecoder().decode([Itinerary].self, from: data) {
            return itineraries
        }
        throw DataError.dataNotFound
    }
}
