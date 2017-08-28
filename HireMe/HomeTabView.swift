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
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardResponseView: UIImageView!
    var divisor: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        divisor = (view.frame.width / 2) / 0.61
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panCardGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        // how far you moved your finger when dragging
        let point = sender.translation(in: view)
        let xFromCenter = cardView.center.x - view.center.x
        cardView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        // 0.61 rads = 35deg
        cardView.transform = CGAffineTransform(rotationAngle:(xFromCenter / divisor))
        
        // we changed alpha of uiimage to 0 to make it not show at 0
        if xFromCenter > 0 {
            cardResponseView.image = #imageLiteral(resourceName: "yesImage")
            cardResponseView.tintColor = UIColor.green
        }
        else {
            cardResponseView.image = #imageLiteral(resourceName: "noImage")
            cardResponseView.tintColor = UIColor.red
        }
        
        cardResponseView.alpha = abs(xFromCenter) / view.center.x
        
        // animating off the screen
        
        if sender.state == UIGestureRecognizerState.ended {
            if cardView.center.x < 75 {
                // move off to left side
                UIView.animate(withDuration: 0.5, animations: {
                    cardView.center = CGPoint(x: cardView.center.x - 200,  y: cardView.center.y - 75)
                    // to hide card
                    cardView.alpha = 0
                }) { (finished) in
                    cardView.center = self.view.center
                    self.cardView.transform = CGAffineTransform.identity
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        cardView.alpha = 1
                    })
                }
                return
            }
            else if cardView.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.5, animations: {
                    cardView.center = CGPoint(x: cardView.center.x + 200,  y: cardView.center.y - 75)
                    cardView.alpha = 0
                }) { (finished) in
                    cardView.center = self.view.center
                    self.cardView.transform = CGAffineTransform.identity
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        cardView.alpha = 1
                    })
                }
                return
            }
            resetCard()
        }
    }
    
    func resetCard()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.cardView.center = self.view.center
            self.cardResponseView.alpha = 0
            self.cardView.alpha = 1
            // resets angle
            self.cardView.transform = CGAffineTransform.identity
        })
    }
    
    
}
