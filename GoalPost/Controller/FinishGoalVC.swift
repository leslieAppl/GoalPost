//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    
    var goalDescription: String?
    var goalType: GoalType?
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
    }
    
    @IBAction func createGoalBtn(_ sender: Any) {
        // Step 1: Pass data into Core Data Model
        let goal = Goal(context: PersistenceServer.context)
        goal.goalDesc = self.goalDescription
        goal.goalType = self.goalType!.rawValue
        goal.goalProgress = Int32(pointsTextField.text!)!
        goal.goalCount = Int32(0)
        PersistenceServer.saveContext()
        // Step 2: append new <Goal> into tableView array
        let goalsVC = GoalsVC()
        goalsVC.goalsForTableView.append(goal)
        print("-> FinishGoalVC.createGoalBtn.goalsForTableView.append(goal).goalsForTableView.count: \(goalsVC.goalsForTableView.count)")
        // Step 3: Post message to NotificationCenter -> After the Observer received the message, it will run the specified function to Update the tableView.
        NotificationCenter.default.post(name: NOTIF_TABLE_VIEW_UPDATED, object: nil)
        // Step 4: Dismiss FinishGoalVC
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pointsTextField.text = ""
        
    }
    
}

