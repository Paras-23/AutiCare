//
//  PictureRepresentingActionViewController.swift
//  AutiCare
//
//  Created by Madhav Verma on 02/06/24.
//

import UIKit


class PictureRepresentingActionViewController: UIViewController {

    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var option1Button: UIButton!
    
    @IBOutlet var option2Button: UIButton!
    
    
    var questions: [QuestionOfPictureRepresentingAction] = []
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the questions
        questions = [
            QuestionOfPictureRepresentingAction(text: "Who is flying?", option1: "notFly", option2: "fly", correctOption: 2),
            QuestionOfPictureRepresentingAction(text: "Who is flying?", option1: "fly1", option2: "notFly1", correctOption: 1),
            QuestionOfPictureRepresentingAction(text: "Who is flying?", option1: "fly2", option2: "notFly2", correctOption: 1),
            QuestionOfPictureRepresentingAction(text: "Who is flying?", option1: "notFly3", option2: "fly3", correctOption: 2),
            QuestionOfPictureRepresentingAction(text: "Who is flying?", option1: "fly4", option2: "notFly4", correctOption: 1)
        ]
        
        displayCurrentQuestion()
    }
    
    func displayCurrentQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.text
        option1Button.setImage(UIImage(named: currentQuestion.option1), for: .normal)
        option2Button.setImage(UIImage(named: currentQuestion.option2), for: .normal)
        
//         Remove any previous markers
        if let overlayImageView = option1Button?.viewWithTag(1001) {
            overlayImageView.removeFromSuperview()
        }
        if let overlayImageView = option2Button?.viewWithTag(1001) {
            overlayImageView.removeFromSuperview()
        }
    }
    
    
    
    @IBAction func option1Tapped(_ sender: Any) {
        checkAnswer(selectedOption: 1)
    }
    
    @IBAction func option2Tapped(_ sender: Any) {
        checkAnswer(selectedOption: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    func checkAnswer(selectedOption: Int) {
        let currentQuestion = questions[currentQuestionIndex]
        if selectedOption == currentQuestion.correctOption {
//             Correct answer
            markAnswerCorrect(selectedOption: selectedOption)
            currentQuestionIndex += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.currentQuestionIndex < self.questions.count {
                    self.displayCurrentQuestion()
                }
                else {
                    self.showGameFinishedAlert()
                }
            }
        } else {
            // Wrong answer
            self.markAnswerWrong(selectedOption: selectedOption)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.displayCurrentQuestion()
            }
        }
    }
    
    func markAnswerCorrect(selectedOption: Int) {
        let correctOption = selectedOption == 1 ? option1Button : option2Button
        
        let overlayImageView = UIImageView(image: UIImage(named: "checkmark"))
        overlayImageView.frame =  CGRect(x: (correctOption?.bounds.midX)! - 20 , y: (correctOption?.bounds.midY)! - 20 , width: 50, height: 50)

        overlayImageView.contentMode = .scaleAspectFit
        overlayImageView.tag = 1001
        correctOption!.addSubview(overlayImageView)
    }
    
    func markAnswerWrong(selectedOption: Int) {
        let wrongOption = selectedOption == 1 ? option1Button : option2Button
        
        let overlayImageView = UIImageView(image: UIImage(named: "crossmark"))
        overlayImageView.frame =  CGRect(x: (wrongOption?.bounds.midX)! - 20 , y: (wrongOption?.bounds.midY)! - 20 , width: 50, height: 50)

        overlayImageView.contentMode = .scaleAspectFit
        overlayImageView.tag = 1001
        wrongOption!.addSubview(overlayImageView)
    }
    
    func showGameFinishedAlert() {
        let alert = UIAlertController(title: "Game Over", message: "You've completed all the questions!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                    self?.performSegue(withIdentifier: "PictureRepresentingActionGameToLearningPageViewController", sender: nil)
                }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)

    }
    
}



