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

class JobPostTabView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var priceGroupTextField: UITextField!
    @IBOutlet weak var estimateTimeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var percentLabel: UILabel!

    
    let loc = CLLocation(latitude: 0, longitude: 0)
    let pickerView = UIPickerView()
    


    
    // array for the scrolling options after called for group text field
    var pickOption = [ "$5", "$10", "$15", "$20", "+$20"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        titleTextField.delegate = self
        //must fix here** descriptionTextField.delegate =
        priceGroupTextField.delegate = self
        estimateTimeTextField.delegate = self
        locationTextField.delegate = self
        
        priceGroupTextField.inputView = pickerView
    

        // Do any additional setup after loading the view, typically from a nib.
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // hides keyboard when touching out 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        priceGroupTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        estimateTimeTextField.resignFirstResponder()
        return true
    }
    
    
    // the following functions related to clicking on price group text field -- scrolling options will pop up.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    @nonobjc func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceGroupTextField.text = pickOption[row]
        self.view.endEditing(false)
    }
    
    
    

    @IBAction func buttonPostTouchInsideUp(_ sender: Any) {
        
        guard let owner = CKHandler.currentUserID else {
        // current userID doesn't exist -- create a new view
        return
        }
        
        // guard works, owner is set to current User ID
            CKHandler.createJobPost(owner: owner, title: titleTextField.text!, desc: descriptionTextField.text!, timeEstimate: 30, priceGroup: priceGroupTextField.text!, loc, onComplete: { (record) in
                print("Uploaded Record Succefullt!")
        }) { (error) in
                print("There was an error: \(error)")
        }
    }
    

}


