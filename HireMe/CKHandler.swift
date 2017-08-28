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
typealias UploadRecordCallback = (CKRecord)  -> Void
typealias ErrorCallback = (Error) -> Void

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
//    ---EXAMPLE USE:---
//    let testLocation = CLLocation(latitude: 0, longitude: 0)
//    
//    CKHandler.fetchLocalJobPosts(testLocation, radiusInMeters: 1600) { (records) in
//        records?.forEach({ (record) in
//            print(record)
//        })
//    }
    
    
    //Creates a new job post and uploads it to cloudKit
    static func createJobPost(owner: String, title: String, desc: String, timeEstimate: Int, priceGroup: Int, _ location:CLLocation, onComplete:@escaping UploadRecordCallback, onUploadError:@escaping ErrorCallback ) {
        let newRecord:CKRecord = CKRecord(recordType: "JobPosts")
        newRecord.setValue(owner, forKey: "owner")
        newRecord.setValue(title, forKey: "title")
        newRecord.setValue(desc, forKey: "desc")
        newRecord.setValue(timeEstimate, forKey: "timeEstimate")
        newRecord.setValue(location, forKey: "location")
        newRecord.setValue(priceGroup, forKey: "priceGroup")
        
        UploadNewRecord(record: newRecord, onComplete: onComplete, onUploadError: onUploadError)
    }
//    ---EXAMPLE USE---
//    let loc = CLLocation(latitude: 0, longitude: 0)
//    CKHandler.createJobPost(owner: "nil", title: "New Job", desc: "This job is fun", timeEstimate: 30, loc, onComplete: { (record) in
//        print("Uploaded Record Succefullt!")
//    }) { (error) in
//        print("There was an error: \(error)")
//    }
    
    
    //Uploads a record to Cloud Kit
    static func UploadNewRecord(record: CKRecord, onComplete:@escaping UploadRecordCallback, onUploadError:@escaping ErrorCallback) {
        let modifyRecordsOperation = CKModifyRecordsOperation(
            recordsToSave: [record],
            recordIDsToDelete: nil)
        
        modifyRecordsOperation.timeoutIntervalForRequest = 10
        modifyRecordsOperation.timeoutIntervalForResource = 10
        
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) -> Void in
            guard let record = record else {
                print("Error saving record: ", error)
                onUploadError(error!)
                return
            }
            onComplete(record)
            
        }
    }
    
}
