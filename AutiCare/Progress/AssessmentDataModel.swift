//
//  AssessmentDataModel.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation

enum Answer: Int {
    case rarely = 1
    case sometimes = 2
    case frequently = 3
    case mostly = 4
    case always = 5
}

enum QuestionCategory {
    case social , emotional , speech , behaviour , sensory , cognitive
}

struct Question1 {
    let category : QuestionCategory
    let questions: [Question]
    let text : String
    let selectedAnswer : Int
}

struct Question {
    let text : String
    let selectedAnswer : Int = 0
}

struct Questionnaire{
    let questions: [Question]
    
    func calculateTotalScore(userAnswers: [Answer]) -> Int {
        var totalScore = 0
        for (index, answer) in userAnswers.enumerated() {
            let question = questions[index]
            totalScore += answer.rawValue
        }
        return totalScore
    }
}

let answerOptions: [Answer] = [.rarely, .sometimes, .frequently, .mostly, .always]

// Define sample questions for each category
let socialQuestions : [Question] = [Question(text: "Has poor eye contact")]
let emotionalQuestions : [Question] = [Question(text: "Has poor eye contact")]
let speechQuestions : [Question] = [Question(text: "Has poor eye contact")]
let behaviourQuestions : [Question] = [Question(text: "Has poor eye contact")]
let sensoryQuestions : [Question] = [Question(text: "Has poor eye contact")]
let cognitiveQuestions : [Question] = [Question(text: "Has poor eye contact")]
//let  = [
//    Question(category: "Emotional", description: "Does your child easily get upset or angry?", answers: answerOptions),
//    // Add more questions for the Emotional category
//]
//
//let speechQuestions = [
//    Question(category: "Speech", description: "Does your child have difficulty speaking clearly?", answers: answerOptions),
//    // Add more questions for the Speech category
//]
//
//let behaviourQuestions = [
//    Question(category: "Behaviour", description: "Does your child have trouble following rules or instructions?", answers: answerOptions),
//    // Add more questions for the Behaviour category
//]
//
//let sensoryQuestions = [
//    Question(category: "Sensory", description: "Does your child show sensitivity to light, sound, or touch?", answers: answerOptions),
//    // Add more questions for the Sensory category
//]
//
//let cognitiveQuestions = [
//    Question(category: "Cognitive", description: "Does your child have difficulty understanding concepts or instructions?", answers: answerOptions),
//    // Add more questions for the Cognitive category
//]

//let questionnaire = Questionnaire(questions: socialQuestions + emotionalQuestions + speechQuestions + behaviourQuestions + sensoryQuestions + cognitiveQuestions)


