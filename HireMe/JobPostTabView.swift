//
//  FirstViewController.swift
//  HireMe
//
//  Created by Skyler Bala on 8/24/17.
//  Copyright © 2017 Bandwidth Bandits. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class JobPostTabView: UIViewController {
    
    var ownerSender
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var priceGroupTextField: UITextField!
    @IBOutlet weak var estimateTimeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var percentLabel: UILabel!
    
    let loc = CLLocation(latitude: 0, longitude: 0)
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPostTouchInsideUp(_ sender: Any) {
        CKHandler.createJobPost(owner: "ownerSender", title: "titleTextField", desc: "descriptionTextField", timeEstimate: estimateTimeTextField, location, onComplete: { (record) in
            print("Uploaded Record Succefullt!")
        }) { (error) in
            print("There was an error: \(error)")
        }
    }

    
    @IBAction func buttonHideKeyboard(_ sender: Any) {
        titleTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        priceGroupTextField.resignFirstResponder()
        estimateTimeTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
    }
    
    

   
    
    
}


