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
            return "SOCIAL RELATIONSHIP AND RECIPROCITY"
        case .emotional :
            return "EMOTIONALRESPONSIVENESS"
        case .speech :
            return "SPEECH-LANGUAGE AND COMMUNICATION"
        case .behaviour :
            return "BEHAVIOUR PATTERNS"
        case .sensory :
            return "SENSORY ASPECTS"
        case .cognitive :
            return "COGNITIVE COMPONENT"
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

let socialQuestions: [Question] = [Question(text: "Has poor eye contact"),
                                   Question(text: "Lacks social smile"),
                                   Question(text: "Remains aloof"),
                                   Question(text: "Does not reach out to others"),
                                   Question(text: "Unable to relate to people"),
                                   Question(text: "Unable to respond to social/environmental cues"),
                                   Question(text: "Engages in solitary and repetitive play activities"),
                                   Question(text: "Unable to take turns in social interaction"),
                                   Question(text: "Does not maintain peer relationships")]

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

