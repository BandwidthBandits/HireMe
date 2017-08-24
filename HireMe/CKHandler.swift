//
//  CKHandler.swift
//  HireMe
//
//  Created by Zac Holland on 8/24/17.
//  Copyright © 2017 Bandwidth Bandits. All rights reserved.
//

import Foundation
import CloudKit

typealias FetchRecordsCallback = ([CKRecord]?) -> Void

class CKHandler {
    static var container: CKContainer?
    static var publicDB: CKDatabase?
    static var privateDB: CKDatabase?
    
    static func initializeCloudkit() {
        // set up the default container
        CKHandler.container = CKContainer.default()
        // get the public database
        CKHandler.publicDB = CKHandler.container?.publicCloudDatabase
        // get the private database
        CKHandler.privateDB = CKHandler.container?.privateCloudDatabase
    }
    
    //NOTE: 1600 meters in a mile
    static func fetchLocalJobPosts(_ location:CLLocation, radiusInMeters:CLLocationDistance, onComplete: @escaping FetchRecordsCallback) {
        
        //make sure public database is set
        guard let pDB = CKHandler.publicDB else {
            print("CKHandler ERROR - publicDB is not set! You haven't called initializeCloudKit yet")
            return
        }
        
        // convert radius in meters to kilometers
        let radiusInKilometers = radiusInMeters / 1000.0
        //set up predicate for query
        let locationPredicate = NSPredicate(format: "distanceToLocation:fromLocation:(%K,%@) < %f", "location", location, radiusInKilometers)
        //set up query based on predicate
        let query = CKQuery(recordType: "JobPosts", predicate: locationPredicate)
        //Execute query
        CKHandler.publicDB?.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                DispatchQueue.main.async {
                    print("Cloud Query Error - Fetch Establishments: \(error)")
                }
                return
            }
            
            onComplete(records)
            
        }
    }
//    EXAMPLE USE:
//    let testLocation = CLLocation(latitude: 0, longitude: 0)
//    
//    CKHandler.fetchLocalJobPosts(testLocation, radiusInMeters: 1600) { (records) in
//        records?.forEach({ (record) in
//            print(record)
//        })
//    }
    
    
}
