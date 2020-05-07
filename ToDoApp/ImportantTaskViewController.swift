//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/17.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import UIKit

class ImportantTaskViewController: UIViewController {
    
    @IBOutlet weak var importantTaskTableView: UITableView!
    
    
    var taskArray:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.importantTaskTableView.delegate = self
        self.importantTaskTableView.dataSource = self
    }
    
    @IBAction func addTasks(_ sender: Any) {
       
    }
    

    
}


extension ImportantTaskViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell") as! taskTableViewCell
        //UITableViewCellを返す
        return cell
        }
    
    
    //UITableViewCellを編集可能な状態にする
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
        taskArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }

}


