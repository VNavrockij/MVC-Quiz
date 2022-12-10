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
    
    var quizBrain = QuizBrain()
    
    let gradient: CAGradientLayer = CAGradientLayer()
    let colors: Colors = Colors()
    var gradientColorSet: [[CGColor]] = []
    var colorIndex: Int = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupGradient()
        animateGradient()
        
        setButtonBorders()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if quizBrain.checkAnswer(sender.currentTitle!) {
            sender.backgroundColor = .green.withAlphaComponent(0.5)
            sender.layer.cornerRadius = 25
        } else {
            sender.backgroundColor = .red.withAlphaComponent(0.5)
            sender.layer.cornerRadius = 25
        }
        
        quizBrain.nextQuestion()
//        quizBrain.randomQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        
        
        firstButton.setTitle(quizBrain.quiz[quizBrain.retQuestNumb()].varAnswers[0], for: .normal)
        secondButton.setTitle(quizBrain.quiz[quizBrain.retQuestNumb()].varAnswers[1], for: .normal)
        thirdButton.setTitle(quizBrain.quiz[quizBrain.retQuestNumb()].varAnswers[2], for: .normal)
        
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        secondButton.backgroundColor = .clear
        firstButton.backgroundColor = .clear
        thirdButton.backgroundColor = .clear
    }
    
    func setButtonBorders() {
        firstButton.layer.borderWidth = 0.7
        firstButton.layer.cornerRadius = 25
        firstButton.layer.borderColor = .init(gray: 0.1, alpha: 0.1)
        
        secondButton.layer.borderWidth = 0.7
        secondButton.layer.cornerRadius = 25
        secondButton.layer.borderColor = .init(gray: 0.1, alpha: 0.1)
        
        thirdButton.layer.borderWidth = 0.7
        thirdButton.layer.cornerRadius = 25
        thirdButton.layer.borderColor = .init(gray: 0.1, alpha: 0.1)
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

