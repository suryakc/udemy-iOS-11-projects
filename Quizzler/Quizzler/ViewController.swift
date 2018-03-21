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
    var incorrectAnswers = 0
    var lastIncorrectQuestionIndex = -1
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if let answer = sender.tag {
            print("Tag value: \(answer)")
            checkAnswer(answer: answer != 0)
        }
    }
    
    
    func updateUI() {
        print(questionBank.currentIndex)
        if let question = questionBank.getCurrent() {
            questionLabel.text = question.questionText
            scoreLabel.text = "\(questionBank.currentIndex - incorrectAnswers)"
            progressLabel.text = "\(questionBank.currentIndex + 1) / \(questionBank.questions.count)"
            progressBar.frame.size.width = (view.frame.size.width/CGFloat(questionBank.questions.count)) * (CGFloat(questionBank.currentIndex + 1))
        } else {
            handleQuizEnd()
        }
    }
    

    func nextQuestion() {
        
    }
    
    
    func checkAnswer(answer: Bool) {
        print(answer)
        if let question = questionBank.getCurrent() {
            if question.answer == answer {
                print("Correct answer...")
                ProgressHUD.showSuccess("Correct!")
                questionBank.goToNext()
                updateUI()
            } else {
                print("Wrong answer...")
                ProgressHUD.showError("Wrong!")
                if lastIncorrectQuestionIndex != questionBank.currentIndex {
                    lastIncorrectQuestionIndex = questionBank.currentIndex
                    incorrectAnswers += 1
                }
                //let alert = UIAlertController(title: "Oops", message: "Your answer is incorrect...", preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                //self.present(alert, animated: true, completion: nil)
            }
        } else {
            handleQuizEnd()
        }
    }
    
    func handleQuizEnd() {
        if questionBank.end() {
            print("No more questions...")
            let alert = UIAlertController(title: "Finished", message: "You have completed the quiz. Your score is \(questionBank.currentIndex - incorrectAnswers).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            startOver()
        }
    }
    
    func startOver() {
        questionBank.resetIndex()
        incorrectAnswers = 0
        lastIncorrectQuestionIndex = -1
        updateUI()
    }
}
