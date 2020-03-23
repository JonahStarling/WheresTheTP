//
//  LaunchViewController.swift
//  WheresTheTP
//
//  Created by Jonah Starling on 3/22/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            TPServices.uid = user.uid
            self.animateToHome()
        }
    }
    
    func setHandsOffScreen() {
        // TODO
    }
    
    func animateToHome() {
        // TODO
        animateTopHandIn()
        animateRightHandIn()
        animateLeftHandIn()
    }
    
    func animateTopHandIn() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut],
        animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            self.animateTopHandOut()
        })
    }
    
    func animateTopHandOut() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseIn],
        animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            // TODO: Should anything happen on completion
        })
    }
    
    func animateRightHandIn() {
        UIView.animate(withDuration: 0.5, delay: 0.15, options: [.curveEaseOut],
        animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            self.animateTopHandOut()
        })
    }
    
    func animateRightHandOut() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseIn],
        animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            // TODO: Should anything happen on completion
        })
    }
    
    func animateLeftHandIn() {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut],
        animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            self.animateTopHandOut()
        })
    }
    
    func animateLeftHandOut() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseIn],
        animations: {
            
            self.view.layoutIfNeeded()
        }, completion: {
            // TODO: Should anything happen on completion
            navigateToHome()
        })
    }
    
    func navigateToHome() {
        // TODO
    }
    
}
