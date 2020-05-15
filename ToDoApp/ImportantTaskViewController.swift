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
    var task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //デリゲートを定義
        importantTaskTableView.delegate = self
        importantTaskTableView.dataSource = self
        
        //データの読み取り処理を行う
        guard let task = task else {
            return
        }
        UserDefaults.standard.loadImportantTask(task: task, index: taskArray.count)
        
        
        //編集ボタンの表示
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem? = editButtonItem
        navigationItem.leftBarButtonItem?.title = "編集"
        //編集ボタンの設定
        importantTaskTableView.isEditing = false
        importantTaskTableView.allowsSelectionDuringEditing = true
    }
    
    //編集モードの切り替え
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        importantTaskTableView.isEditing = editing
        if importantTaskTableView.isEditing == false {
            //cellの編集前の編集ボタンのタイトル
            navigationItem.leftBarButtonItem?.title = "編集"
        } else if importantTaskTableView.isEditing == true {
            //cellの編集時の編集ボタンのタイトル
            navigationItem.leftBarButtonItem?.title = "完了"
        }
    }
    
}


extension ImportantTaskViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell") as! taskTableViewCell
        cell.setup(task: taskArray[indexPath.row], index: indexPath.row)
        return cell
    }
    
    //tableViewの編集を許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cellが編集モード中に移動できるか指定
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cellの並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    //cellの編集を可能にする
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
    
    //UITableViewCellを編集を削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            //UserDefaultsからcellを削除
            UserDefaults.standard.delete(index: indexPath.row)
        }
        
    }
    
}


