//
//  AssessmentDataModel.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation


enum QuestionCategory {
    case social , emotional , speech , behaviour , sensory , cognitive
    
    var description : String {
        switch self {
        case .social :
            return "Social Relationship and Responsiveness"
        case .emotional :
            return "Emotional Responsiveness"
        case .speech :
            return "Speech language and Communication"
        case .behaviour :
            return "Behaviour Patterns"
        case .sensory :
            return "Sensory Aspects"
        case .cognitive :
            return "Cognitive Components"
        }
    }
    
}

struct Question {
    let text : String
    var selectedAnswer : Int = 0
}

struct CategoryWiseQuestions {
    var AllQuestions : [CategoryWiseQuestion] = [CategoryWiseQuestion(questions: socialQuestions, questionsCategory: .social),
                                   CategoryWiseQuestion(questions: emotionalQuestions, questionsCategory: .emotional),
                                   CategoryWiseQuestion(questions: speechQuestions, questionsCategory: .speech),
                                   CategoryWiseQuestion(questions: behaviourQuestions, questionsCategory: .behaviour),
                                   CategoryWiseQuestion(questions: sensoryQuestions, questionsCategory: .sensory),
                                   CategoryWiseQuestion(questions: cognitiveQuestions, questionsCategory: .cognitive)]
}

struct CategoryWiseQuestion {
    var questions : [Question]
    var questionsCategory : QuestionCategory
    var score : Int = 0
}

let socialQuestions: [Question] = [Question(text: "Your child has poor eye contact"),
                                   Question(text: "Your child lacks social smile"),
                                   Question(text: "Your child remains aloof"),
                                   Question(text: "Your child does not reach out to others"),
                                   Question(text: "Your child unable to relate to people"),
                                   Question(text: "Your child is unable to respond to social/environmental cues"),
                                   Question(text: "Your child engages in solitary and repetitive play activities"),
                                   Question(text: "Your child is unable to take turns in social interaction"),
                                   Question(text: "Your child does not maintain peer relationships")]

let emotionalQuestions : [Question] = [Question(text: "Your child shows inappropriate emotional response"),
                                       Question(text: "Your child shows exaggerated emotions"),
                                       Question(text: "Your child engages in self-stimulating emotions"),
                                       Question(text: "Your child lacks fear of danger"),
                                       Question(text: "Your child gets excited or agitated for no apparent reason")]

let speechQuestions : [Question] = [Question(text: "Your child acquired speech and lost it"),
                                    Question(text: "Your child has difficulty in using non-verbal language or gestures to communicate"),
                                    Question(text: "Your child engages in stereotyped and repetitive use of language"),
                                    Question(text: "Your child engages in echolalic speech"),
                                    Question(text: "Your child produces infantile squeals/unusual noises"),
                                    Question(text: "Your child is unable to initiate or sustain conversation with others"),
                                    Question(text: "Your child uses jargon or meaningless words"),
                                    Question(text: "Your child uses pronoun reversals"),
                                    Question(text: "Your child is unable to grasp pragmatics of communication (real meaning)")]

let behaviourQuestions : [Question] = [Question(text: "Your child engages in stereotyped and repetitive motor mannerisms"),
                                        Question(text: "Your child shows attachment to inanimate objects"),
                                        Question(text: "Your child shows hyperactivity/restlessness"),
                                        Question(text: "Your child exhibits aggressive behavior"),
                                        Question(text: "Your child throws temper tantrums"),
                                        Question(text: "Your child engages in self-injurious behavior"),
                                        Question(text: "Your child insists on sameness")]

let sensoryQuestions : [Question] = [Question(text: "Your child unusually sensitive to sensory stimuli"),
                                     Question(text: "Your child stares into space for long periods of time"),
                                     Question(text: "Your child has difficulty in tracking objects"),
                                     Question(text: "Your child has unusual vision"),
                                     Question(text: "Your child is insensitive to pain"),
                                     Question(text: "Your child responds to objects/people unusually by smelling, touching or tasting")]

let cognitiveQuestions : [Question] = [Question(text: "Your child is inconsistent attention and concentrationt"),
                                       Question(text: "Your child shows delay in responding"),
                                       Question(text: "Your child has unusual memory of some kind"),
                                       Question(text: "Your child has 'savant' ability")]


struct Result {
    var scores : [Int]
    var date : Date
}

var assessmentResults : [Result] = []
