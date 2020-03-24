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
    
    @IBOutlet weak var logoTopLine: UILabel!
    @IBOutlet weak var logoBottomLine: UILabel!
    
    @IBOutlet weak var topHand: UIImageView!
    @IBOutlet weak var rightHand: UIImageView!
    @IBOutlet weak var leftHand: UIImageView!
    @IBOutlet weak var topTP: UIImageView!
    @IBOutlet weak var rightTP: UIImageView!
    @IBOutlet weak var leftTP: UIImageView!
    
    var initialPositionTopHand = CGFloat.zero
    var initialPositionRightHand = CGFloat.zero
    var initialPositionLeftHand = CGFloat.zero
    var finalPositionTopHand = CGFloat.zero
    var finalPositionRightHand = CGFloat.zero
    var finalPositionLeftHand = CGFloat.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setInitialHandPositions()
        setFinalHandPositions()
        setHandsOffScreen()
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            TPServices.uid = user.uid
            self.animateToHome()
        }
    }
   
    private func setInitialHandPositions() {
        initialPositionTopHand = 0 - topHand.bounds.height / 2
        initialPositionRightHand = view.bounds.width + (rightHand.bounds.width / 2)
        initialPositionLeftHand = 0 - leftHand.bounds.width / 2
    }
    
    private func setFinalHandPositions() {
        finalPositionTopHand = topHand.center.y
        finalPositionRightHand = rightHand.center.x
        finalPositionLeftHand = leftHand.center.x
    }
    
    private func setHandsOffScreen() {
        // TODO
        topHand.center.y = initialPositionTopHand
        rightHand.center.x = initialPositionRightHand
        leftHand.center.x = initialPositionLeftHand
        view.layoutIfNeeded()
    }
    
    func animateToHome() {
        // TODO
        animateTopHandIn()
        animateRightHandIn()
        animateLeftHandIn()
    }
    
    func animateTopHandIn() {
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseOut],
        animations: {
            self.topHand.center.y = self.finalPositionTopHand
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.animateTopHandOut()
        })
    }
    
    func animateTopHandOut() {
        let distanceBetweenCenterPoints = topTP.center.y - topHand.center.y
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseIn],
        animations: {
            // The extra -50 is just a little extra to get it fully off the screen
            // There's definitely a better way to do this but oh well
            let tpFinal = (0 - self.topTP.bounds.height / 2) + -50
            self.topHand.center.y = tpFinal - distanceBetweenCenterPoints
            self.topTP.center.y = tpFinal
            self.view.layoutIfNeeded()
        })
    }
    
    func animateRightHandIn() {
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseOut],
        animations: {
            self.rightHand.center.x = self.finalPositionRightHand
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.animateRightHandOut()
        })
    }
    
    func animateRightHandOut() {
        let distanceBetweenCenterPoints = rightHand.center.x - rightTP.center.x
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseIn],
        animations: {
            let tpFinal = self.view.bounds.width + (self.rightTP.bounds.width / 2)
            self.rightHand.center.x = tpFinal + distanceBetweenCenterPoints
            self.rightTP.center.x = tpFinal
            self.view.layoutIfNeeded()
        })
    }
    
    func animateLeftHandIn() {
        UIView.animate(withDuration: 0.45, delay: 0.25, options: [.curveEaseOut],
        animations: {
            self.leftHand.center.x = self.finalPositionLeftHand
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.animateLeftHandOut()
        })
    }
    
    func animateLeftHandOut() {
        let distanceBetweenCenterPoints = leftTP.center.x - leftHand.center.x
        UIView.animate(withDuration: 0.45, delay: 0.1, options: [.curveEaseIn],
        animations: {
            let tpFinal = 0 - self.leftTP.bounds.height / 2
            self.leftHand.center.x = tpFinal - distanceBetweenCenterPoints
            self.leftTP.center.x = tpFinal
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.navigateToHome()
        })
    }
    
    func navigateToHome() {
        performSegue(withIdentifier: "launchToHome", sender: nil)
    }
    
}
