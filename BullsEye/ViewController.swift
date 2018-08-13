//
//  ViewController.swift
//  BullsEye
//
//  Created by Leo Vujanić on 11/08/2018.
//  Copyright © 2018 Leo Vujanić. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var initialSliderValue = 0
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var startOver: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSliderValue = lroundf(slider.value)
        resetGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
//        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 1, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        slider.setMaximumTrackImage(trackRightResizable, for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startNewRound() {
        round += 1
        currentValue = initialSliderValue
        slider.value = Float(currentValue)
        targetValue = 1 + Int(arc4random_uniform(100))
        
        updateLabels()
    }
    
    func updateLabels() {
        targetValueLabel.text = String(targetValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }
    
    func getAlertTitle(difference: Int) -> String {
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        return title
    }
    
    @IBAction func resetGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func sliderMove(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showHitMeAlert() {
        let difference = abs(currentValue - targetValue)
        let points: Int = difference == 0 ? 200 : 100 - difference
        score += points
        
        let title = self.getAlertTitle(difference: difference)
        
        let message = "You scored \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }


}

