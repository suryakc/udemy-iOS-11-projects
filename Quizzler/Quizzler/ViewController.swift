//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2018 Apollo App Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var questionBank = QuestionBank()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let question = questionBank.getCurrent() {
            questionLabel.text = question.questionText
            scoreLabel.text = "0"
        }
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if let answer = sender.tag {
            checkAnswer(answer: answer != 0)
        }
    }
    
    
    func updateUI() {
        if let question = questionBank.getCurrent() {
            questionLabel.text = question.questionText
            scoreLabel.text = "\(questionBank.currentIndex + 1)"
        }
    }
    

    func nextQuestion() {
        
    }
    
    
    func checkAnswer(answer: Bool) {
        if let question = questionBank.getCurrent() {
            if question.answer == answer {
                questionBank.goToNext()
                updateUI()
            } else {
                //let alert = UIAlertController(title: "Oops", message: "Your answer is incorrect...", preferredStyle: .alert)
                //alert.show(this, sender: <#T##Any?#>)
            }
        }
    }
    
    
    func startOver() {
       questionBank.resetIndex()
    }
    

    
}
