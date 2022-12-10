//
//  Question.swift
//  Quiz-MVC
//
//  Created by Vitalii Navrotskyi on 10.12.2022.
//

import Foundation

struct Question {
    let text: String
    let varAnswers: [String]
    let answer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.text = q
        self.varAnswers = a
        self.answer = correctAnswer
    }
}
