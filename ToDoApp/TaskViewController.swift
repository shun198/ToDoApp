//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/17.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import UIKit

//ViewControllerについて
class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var insertTaskTextField: UITextField!
    
    //taskTableViewのセルに出力される配列を定義
    var taskArray:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //デリゲートを定義
        taskTableView.delegate = self
        taskTableView.dataSource = self
        //データの読み取り処理を行う
        taskArray = UserDefaults.standard.load()
        //編集ボタンの表示
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem? = editButtonItem
        navigationItem.leftBarButtonItem?.title = "編集"
        //編集ボタンの設定
       taskTableView.isEditing = false
       taskTableView.allowsSelectionDuringEditing = true
    }
    
    //編集モードの切り替え
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        taskTableView.isEditing = editing
        if taskTableView.isEditing == false {
            //cellの編集前の編集ボタンのタイトル
             navigationItem.leftBarButtonItem?.title = "編集"
         } else if taskTableView.isEditing == true {
            //cellの編集時の編集ボタンのタイトル
             navigationItem.leftBarButtonItem?.title = "完了"
         }
    }
    
    //タスクを追加
    func insertNewTask() {
        if let text = insertTaskTextField.text {
        let task = Task(task: text)
        taskArray.append(task)
        UserDefaults.standard.save(task)
        taskTableView.reloadData()
        insertTaskTextField.text = ""
        } else {
            print("error")
        }
    }
    
    //textFieldの中身が空の時、警告が出る
    func showAlert() {
        let alert = UIAlertController(title:"",
        message: "タスクを入力してください",
        preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true, completion: nil)
        //3秒後にアラートが消える
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    //addNewTaskButtonが押された時の処理
    @IBAction func addNewTaskButton(_ sender: Any) {
        //textFieldの中身が空の時、警告が出る
        if insertTaskTextField.text == "" {
            showAlert()
            return
        }
        //addNewTaskButtonを押すとタスクが追加される
        insertNewTask()
    }

}

//tableViewについて
extension TaskViewController: UITableViewDelegate,UITableViewDataSource {
    //taskArray内の数だけtableView内のセルが出力される
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    //textfieldに入力したタスクを配列に加える
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
    
    //tableView内のセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //画面上のcellを削除
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskArray.remove(at: indexPath.row)
            taskTableView.deleteRows(at: [indexPath as IndexPath],
            with:UITableView.RowAnimation.automatic)
            //UserDefaultsからcellを削除
            UserDefaults.standard.delete(index: indexPath.row)
        }
    }

  }

//textFieldについて
extension TaskViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // returnキーを押した時の処理
        //textFieldの中身が空の時、警告が出る
        if insertTaskTextField.text == "" {
            showAlert()
            return true
        } else {
            insertNewTask()
            return true
        }
    }
}
