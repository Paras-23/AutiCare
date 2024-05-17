//
//  AssesmentTableViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 17/05/24.
//

import UIKit

class AssesmentTableViewController: UITableViewController {
    
    var questions : [Question]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "segueToQuestionTableViewController", sender: indexPath)
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch sender as? IndexPath {
        case IndexPath(row: 0, section: 1) : questions = socialQuestions
        case IndexPath(row: 1, section: 1) : questions = emotionalQuestions
        case IndexPath(row: 2, section: 1) : questions = speechQuestions
        case IndexPath(row: 3, section: 1) : questions = behaviourQuestions
        case IndexPath(row: 4, section: 1) : questions = sensoryQuestions
        case IndexPath(row: 5, section: 1) : questions = cognitiveQuestions
        default : break
        }
        
        if let questionsControl = segue.destination as? QuestionsTableViewController {
            questionsControl.questions = questions ?? []
        }
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

}
