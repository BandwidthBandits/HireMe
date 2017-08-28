//
//  FirstViewController.swift
//  HireMe
//
//  Created by Skyler Bala on 8/24/17.
//  Copyright © 2017 Bandwidth Bandits. All rights reserved.
//

import Foundation
import UIKit

class SettingsTabView: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        
        profilePicture.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
