//
//  Journal.swift
//  REMOLD
//

import UIKit
import os.log

class Journal: NSObject, NSCoding {
    
    // Properties
    var date: Date
    var entry: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("journals")
    
    // Types
    struct PropertyKey {
        static let date = "date"
        static let entry = "entry"
    }
    
    //MARK: Initialization
    
    init?(date: Date, entry: String) {
        
        // The date must not be empty
        // TO DO LATER
        
        // The entry must not be empty
        guard !entry.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.date = date
        self.entry = entry
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(entry, forKey: PropertyKey.entry)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The entry is required. If we cannot decode a name string, the initializer should fail.
        guard let entry = aDecoder.decodeObject(forKey: PropertyKey.entry) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Date
        
        // Must call designated initializer.
        self.init(date: date!, entry: entry)
    }
}
