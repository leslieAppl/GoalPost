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
    
    func fetchCoreData(completion: (_ completed: Bool) -> ()) {
        // Fetch Core Data
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        goalsForTableView = try! PersistenceServer.context.fetch(fetchRequest)
        print("-> GoalsVC.viewDidLoad.goalsForTableView: \(goalsForTableView.count)")
        completion(true)
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
}
