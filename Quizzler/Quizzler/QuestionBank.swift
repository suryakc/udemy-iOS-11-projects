//
//  QuestionBank.swift
//  Quizzler
//
//  Created by Surya Chundru on 20/03/18.
//  Copyright © 2018 Apollo App Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionBank {
    
    var currentIndex = 0
    var questions = [Question]()
    
    init() {
        loadQuestions()
    }
    
    func getNext() -> Question? {
        if 0 <= currentIndex && currentIndex < questions.count {
            let nextQuestion = questions[currentIndex]
            currentIndex += 1
            return nextQuestion
        } else {
            return nil
        }
    }
    
    func getCurrent() -> Question? {
        if 0 <= currentIndex && currentIndex < questions.count {
            return questions[currentIndex]
        } else {
            return nil
        }
    }
    
    func getPrevious() -> Question? {
        let previousIndex = currentIndex - 1
        if 0 > previousIndex {
            return nil
        }
        currentIndex -= 1
        return questions[previousIndex]
    }
    
    func resetIndex() {
        currentIndex = 0
    }
    
    func goToNext() {
        currentIndex += 1
    }
    
    func goToPrevious() {
        currentIndex -= 1
    }
    
    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                print("jsonData:\(jsonObj)")
                for questionFromJSON in jsonObj["questions"].arrayValue {
                    let questionTextFromJSON = questionFromJSON["questionText"].stringValue
                    let answerFromJSON = questionFromJSON["answer"].boolValue
                    questions.append(Question(questionText: questionTextFromJSON, answer: answerFromJSON))
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func addQuestions() {
        // Creating a quiz item and appending it to the list
        let item = Question(questionText: "Valentine\'s day is banned in Saudi Arabia.", answer: true)
        
        // Add the Question to the list of questions
        questions.append(item)
        
        // skipping one step and just creating the quiz item inside the append function
        questions.append(Question(questionText: "A slug\'s blood is green.", answer: true))
        
        questions.append(Question(questionText: "Approximately one quarter of human bones are in the feet.", answer: true))
        
        questions.append(Question(questionText: "The total surface area of two human lungs is approximately 70 square metres.", answer: true))
        
        questions.append(Question(questionText: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", answer: true))
        
        questions.append(Question(questionText: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", answer: false))
        
        questions.append(Question(questionText: "It is illegal to pee in the Ocean in Portugal.", answer: true))
        
        questions.append(Question(questionText: "You can lead a cow down stairs but not up stairs.", answer: false))
        
        questions.append(Question(questionText: "Google was originally called \"Backrub\".", answer: true))
        
        questions.append(Question(questionText: "Buzz Aldrin\'s mother\'s maiden name was \"Moon\".", answer: true))
        
        questions.append(Question(questionText: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", answer: false))
        
        questions.append(Question(questionText: "No piece of square dry paper can be folded in half more than 7 times.", answer: false))
        
        questions.append(Question(questionText: "Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.", answer: true))
    }
    
}
