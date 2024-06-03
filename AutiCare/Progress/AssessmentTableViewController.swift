//
//  AssesmentTableViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 17/05/24.
//

import UIKit

class AssessmentTableViewController: UITableViewController {
    
    var categoryWiseQuestions = CategoryWiseQuestions()
    var autismScore : Int = 0
    
    @IBOutlet var submitButtonPressed: UIButton!
    
    var isCompletedCategory : [Bool] = []{
        didSet{
            updateSubmitButtonState()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isCompletedCategory = Array(repeating: false, count: categoryWiseQuestions.AllQuestions.count)
        updateSubmitButtonState()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 6: break
        default: performSegue(withIdentifier: "segueToQuestionTableViewController", sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "segueToQuestionTableViewController" {
            guard let questionsControl = segue.destination as? QuestionsTableViewController else {
                return
            }
            
            let indexPath = sender as! IndexPath
            questionsControl.categoryWiseQuestion = categoryWiseQuestions.AllQuestions[indexPath.row]
            questionsControl.navigationItem.title = categoryWiseQuestions.AllQuestions[indexPath.row].questionsCategory.description
        }
        else if segue.identifier == "segueToResultPageViewController" {
            
        }
        else if segue.identifier == "unwindToProgressPageViewController"{
            autismScore = categoryWiseQuestions.AllQuestions.reduce(0){$0 + $1.score}
        }
        
    }
    
    func updateSubmitButtonState(){
        for category in isCompletedCategory {
            if category == true {
                continue
            }
            else {
                submitButtonPressed.isEnabled = false
                return
            }
        }
        submitButtonPressed.isEnabled = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToAssessmentTableViewController (segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! QuestionsTableViewController
        
        let total = sourceViewController.total
        let updatedSelectedAnswerQuestions = sourceViewController.questions
        var index = 0
        let selectedCategory = sourceViewController.categoryWiseQuestion
        for category in categoryWiseQuestions.AllQuestions {
            if selectedCategory?.questionsCategory == category.questionsCategory{
                break
            }
            index += 1
        }
        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
        cell?.backgroundColor = .systemMint
        
        isCompletedCategory[index] = true
        
        categoryWiseQuestions.AllQuestions[index].score = total
        categoryWiseQuestions.AllQuestions[index].questions = updatedSelectedAnswerQuestions
    }
    
}
