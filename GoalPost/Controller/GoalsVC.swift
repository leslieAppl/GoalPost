//
//  ViewController.swift
//  GoalPost
//
//  Created by leslie on 10/3/19.
//  Copyright © 2019 leslie. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var goalsForTableView: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch Core Data + Update TableView
        updateTableView()

        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NOTIF_TABLE_VIEW_UPDATED, object: nil)
    }
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        let chosenGoal = self.goalsForTableView[indexPath.row]
        if chosenGoal.goalProgress > 0 {
            chosenGoal.goalProgress -= 1
        } else { return }
        PersistenceServer.saveContext()
    }
    
    // fetch core data
    func fetchCoreData(completion: (_ completed: Bool) -> ()) {
        // Fetch Core Data
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        goalsForTableView = try! PersistenceServer.context.fetch(fetchRequest)
        print(">> GoalsVC.viewDidLoad.goalsForTableView: \(goalsForTableView.count)")
        completion(true)
    }
    
    // remove core data
    func removeCoreData(atIndexPath indexPath: IndexPath) {
        let context = PersistenceServer.context
        print(">> GoalsVC.removeCoreData.context: \(context)")
        // take the Core data type - Goal's preference into the context.delete() function.
        context.delete(goalsForTableView[indexPath.row])
        PersistenceServer.saveContext()
    }
    
    @objc func updateTableView() {
        // Fetch Core Data
        self.fetchCoreData { (completed) in
            if completed {
                if goalsForTableView.count > 0 {
                    self.tableView.isHidden = false
                } else { self.tableView.isHidden = true }
            }
            self.tableView.reloadData()
        }
    }

    @IBAction func addGoalBtn(_ sender: Any) {
        
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell()}
        cell.configureCell(goal: goalsForTableView[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeCoreData(atIndexPath: indexPath)
            self.fetchCoreData { (completed) in
                if completed {
                    // deleteRows() action is individual from the fetchCoreData() action.
                    // One is for deleting one row of the tableView, the other is for deleting a Core Data record. They just share the one Selected IndexPath to do their own stuff!
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    if self.goalsForTableView.count ==
                        0 {
                        self.tableView.isHidden = true
                    }
                }
            }
        }
        
        let countProgressAction = UITableViewRowAction(style: .normal, title: "+1 Point") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            // just reload one row's data, not the whole tableView.
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        deleteAction.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        countProgressAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 0.75)
        return [deleteAction, countProgressAction]
    }
}
