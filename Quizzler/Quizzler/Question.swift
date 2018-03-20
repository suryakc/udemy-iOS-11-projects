//
//  Question.swift
//  Quizzler
//
//  Created by Surya Chundru on 20/03/18.
//  Copyright © 2018 Apollo App Studio. All rights reserved.
//

import Foundation


class Question {
    
    let questionText : String
    let answer : Bool
    
    init(questionText: String, answer: Bool) {
        self.questionText = questionText
        self.answer = answer
    }
}

