//
//  ViewController.swift
//  Quiz-MVC
//
//  Created by Vitalii Navrotskyi on 10.12.2022.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let colors: Colors = Colors()
    var gradientColorSet: [[CGColor]] = []
    var colorIndex: Int = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupGradient()
        animateGradient()
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        print("hello")
        
        

//        print("Hello, MVC!")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animateGradient()
        }
    }
    
    func setupGradient(){
        gradientColorSet = [
            [colors.color1, colors.color2],
            [colors.color2, colors.color3],
            [colors.color3, colors.color1]
        ]
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientColorSet[colorIndex]

//        self.view.layer.addSublayer(gradient)
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func animateGradient() {
        gradient.colors = gradientColorSet[colorIndex]
        
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.delegate = self
        gradientAnimation.duration = 3.0
        
        updateColorIndex()
        gradientAnimation.toValue = gradientColorSet[colorIndex]
        
        gradientAnimation.fillMode = .forwards
        gradientAnimation.isRemovedOnCompletion = false
        
        gradient.add(gradientAnimation, forKey: "colors")
    }
    
    func updateColorIndex(){
        if colorIndex < gradientColorSet.count - 1 {
            colorIndex += 1
        } else {
            colorIndex = 0
        }
    }
}

