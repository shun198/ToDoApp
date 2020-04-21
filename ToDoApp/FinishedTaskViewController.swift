//
//  FinishedTaskViewController.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/17.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import UIKit

class FinishedTaskViewController: UIViewController {
    
    @IBOutlet weak var finishedTaskTableView: UITableView!
    
    var taskArray = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.finishedTaskTableView.delegate = self
        self.finishedTaskTableView.dataSource = self
        
        let scrollView = UIScrollView()
        //scrollViewの大きさを設定。
        scrollView.frame = self.finishedTaskTableView.frame
        scrollView.contentSize = CGSize(width:self.finishedTaskTableView.frame.width, height:1000)
        self.finishedTaskTableView.addSubview(scrollView)
        
    }
    
}


extension FinishedTaskViewController: UITableViewDelegate,UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == UITableViewCell.EditingStyle.delete {
            taskArray.remove(at: indexPath.row)
            finishedTaskTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
         }
     }
    
    
}
