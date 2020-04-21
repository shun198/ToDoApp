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
    
    var taskArray = ["北海道","青森県"]
    
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.taskArray[indexPath.row]
        //UITableViewCellを返す
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの行番号を出力
        print("\(indexPath.row)番目の行が選択されました。")
    }
    
    //UITableViewCellを編集可能な状態にする
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
        taskArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }

}


