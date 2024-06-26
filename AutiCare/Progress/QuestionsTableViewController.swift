//
//  QuestionsTableViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 17/05/24.
//

import UIKit

class QuestionsTableViewController: UITableViewController , QuestionTableViewCellDelegate {
    func didSelectButton(cell: QuestionTableViewCell, answer: Int) {
        if let indexPath = tableView.indexPath(for: cell) {
            questions[indexPath.row].selectedAnswer = answer
        }
    }
    
    var categoryWiseQuestion : CategoryWiseQuestion?
    
    var questions : [Question] = [] {
        didSet {
            updateDoneButtonState()
        }
    }
    
    
    var total : Int = 0
    
    @IBOutlet var doneButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = categoryWiseQuestion!.questions
        updateDoneButtonState()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Question", for: indexPath) as! QuestionTableViewCell
        
        cell.delegate = self
        // Configure the cell...
        cell.questionLabel.text = questions[indexPath.row].text
        for button in cell.buttonsPressed {
            button.backgroundColor = cell.defaultBackgroundConfiguration().backgroundColor
        }
        
        if questions[indexPath.row].selectedAnswer != 0 {
            cell.viewWithTag(questions[indexPath.row].selectedAnswer)?.backgroundColor = .systemMint
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateDoneButtonState(){
        for ans in questions {
            if ans.selectedAnswer != 0 {
                continue
            }
            else {
                doneButton.isEnabled = false
                return
            }
        }
        doneButton.isEnabled = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        total = questions.reduce(0){ $0 + $1.selectedAnswer}
    }
}
