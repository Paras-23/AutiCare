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
    var totalScore : Int
}

var assessmentResults : [Result] = []

var results : [String] = [
"Your child's assessment indicates typical development with no significant signs of autism. Children at this level generally exhibit age-appropriate social interactions, communication skills, and behaviors. They navigate daily activities and changes in routine with ease. While every child develops at their own pace, your child's current developmental profile is within the expected range for their age",

"Your child's assessment indicates a mild level of autism. Children at this level may have some difficulties with social interactions and communication, and might exhibit repetitive behaviors. They often require minimal support and can manage many daily activities independently. With early intervention and appropriate support, children with mild autism can develop important skills to enhance their social and adaptive functioning",

"Your child's assessment indicates a moderate level of autism. Children at this level often face more pronounced challenges with communication and social interactions. They may exhibit repetitive behaviors and have difficulty adapting to changes in routine. They typically require moderate support to assist with daily activities and benefit from targeted interventions to improve their social skills and adaptive functioning.",

"Your child's assessment indicates a severe level of autism. Children at this level usually experience significant challenges with communication and social interactions. They may exhibit repetitive behaviors and have a strong preference for routines. They often require substantial support and specialized interventions to assist with daily functioning and to improve their quality of life. Early and intensive interventions can help in developing essential skills and enhancing their overall well-being."
]
