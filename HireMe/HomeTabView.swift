//
//  SecondViewController.swift
//  HireMe
//
//  Created by Skyler Bala on 8/24/17.
//  Copyright © 2017 Bandwidth Bandits. All rights reserved.
//

import Foundation
import UIKit

class HomeTabView: UIViewController {

    @IBOutlet weak var jobPostingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let jobPostingView = UIView()
        jobPostingView.backgroundColor = .red
        view.addSubview(jobPostingView)
        jobPostingView.layer.borderWidth = 0.5
        jobPostingView.layer.borderColor = UIColor.black.cgColor


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
