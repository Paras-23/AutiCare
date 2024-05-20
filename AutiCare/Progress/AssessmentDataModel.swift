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
    var selectedAnswer : Int = 0
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
let socialQuestions: [Question] = [Question(text: "Has poor eye contact"),
                                   Question(text: "Lacks social smile"),
                                   Question(text: "Remains aloof"),
                                   Question(text: "Does not reach out to others"),
                                   Question(text: "Unable to relate to people"),
                                   Question(text: "Unable to respond to social/environmental cues"),
                                   Question(text: "Engages in solitary and repetitive play activities"),
                                   Question(text: "Unable to take turns in social interaction"),
                                   Question(text: "Does not maintain peer relationships")
]
let emotionalQuestions : [Question] = [Question(text: "Shows inappropriate emotional response"),
                                       Question(text: "Shows exaggerated emotions"),
                                       Question(text: "Engages in self-stimulating emotions"),
                                       Question(text: "Lacks fear of danger"),
                                       Question(text: "Excited or agitated for no apparent reason")]

let speechQuestions : [Question] = [Question(text: "Acquired speech and lost it"),
                                    Question(text: "Has difficulty in using non-verbal language or gestures to communicate"),
                                    Question(text: "Engages in stereotyped and repetitive use of language"),
                                    Question(text: "Engages in echolalic speech"),
                                    Question(text: "Produces infantile squeals/unusual noises"),
                                    Question(text: "Unable to initiate or sustain conversation with others"),
                                    Question(text: "Uses jargon or meaningless words"),
                                    Question(text: "Uses pronoun reversals"),
                                    Question(text: "Unable to grasp pragmatics of communication (real meaning)")]
let behaviourQuestions : [Question] = [Question(text: "Engages in stereotyped and repetitive motor mannerisms"),
                                        Question(text: "Shows attachment to inanimate objects"),
                                        Question(text: "Shows hyperactivity/restlessness"),
                                        Question(text: "Exhibits aggressive behavior"),
                                        Question(text: "Throws temper tantrums"),
                                        Question(text: "Engages in self-injurious behavior"),
                                        Question(text: "Insists on sameness")]
let sensoryQuestions : [Question] = [Question(text: "Unusually sensitive to sensory stimuli"),
                                     Question(text: "Stares into space for long periods of time"),
                                     Question(text: "Has difficulty in tracking objects"),
                                     Question(text: "Has unusual vision"),
                                     Question(text: "Insensitive to pain"),
                                     Question(text: "Responds to objects/people unusually by smelling, touching or tasting")]
let cognitiveQuestions : [Question] = [Question(text: "Inconsistent attention and concentrationt"),
                                       Question(text: "Shows delay in responding"),
                                       Question(text: "Has unusual memory of some kind"),
                                       Question(text: "Has 'savant' ability")]

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


