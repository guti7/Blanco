//
//  ViewController.swift
//  Blanco
//
//  Created by Guti on 1/14/17.
//  Copyright © 2017 PielDeJaguar. All rights reserved.
//

// MARK: TODO - Add support for iPhone4

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    // MARK: - Variables
    var currentValue: Int!
    var targetValue: Int!
    var score = 0
    var round = 0
    
    // MARK: - Outlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    // MARK: - Actions
    
    // Show alert when user preses hit me button
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        // current round points
        var points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            // bonus points
            points += 100
        } else if difference < 5 {
            title = "You almost had it."
            // bonus points
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good."
        } else {
            title = "Not even close..."
        }
        
        // update game score
        score += points
        let message = "You scored \(points) points."
        
        // Present alert to user
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Dismiss alert to start a new round
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.startNewRound()
            self.updateLabels()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Detects changes in the slider
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    // New game
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        // transition states to new game
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    // Start a new playing round by getting a new target value, resetting
    // the current value, and the slider view
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 1
        slider.value = Float(currentValue)
    }
    
    // Update the interface labels to the current variables' state
    func updateLabels() {
        targetLabel.text = String(targetValue!)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    
    // MARK: - App lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up the starting round
        startNewGame()
        updateLabels()
        
        // set up view for slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlited = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
            slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
            slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        }
    }
}
