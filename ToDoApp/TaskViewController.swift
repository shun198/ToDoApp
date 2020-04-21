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
    //初期値として"タスク"が入っている
    var taskArray = ["タスク"]
    //userDefaultsのインスタンスを定義
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //デリゲートを定義
        self.taskTableView.delegate = self
        self.taskTableView.dataSource = self
        self.insertTaskTextField.delegate = self
        //アプリ起動時の編集ボタンのタイトル
        
        //デフォルトでアプリ起動時の編集ボタンはOFF
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem? = editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "編集"
        //UserDefaultsを使ってアプリ再起動後もデータを保持
        if let insertedText = userDefaults.object(forKey: "taskArray") {
            taskArray = insertedText as! Array<String>
        }
        //tableViewの編集
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
    
    //タスクを追加
    func insertNewTask() {
        taskArray.append(insertTaskTextField.text!)
        let indexPath = IndexPath(row: taskArray.count-1, section: 0)
        taskTableView.beginUpdates()
        taskTableView.insertRows(at: [indexPath], with: .automatic)
        taskTableView.endUpdates()
        insertTaskTextField.text = ""
        view.endEditing(true)
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
    
}

//tableViewについて
extension TaskViewController: UITableViewDelegate,UITableViewDataSource {
    //taskArray内の数だけtableView内のセルが出力される
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count
    }
    
    //tableViewのセルについて
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.taskArray[indexPath.row]
        //UITableViewCellを返す
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
        if editingStyle == UITableViewCell.EditingStyle.delete {
            taskArray.remove(at: indexPath.row)
            taskTableView.deleteRows(at: [indexPath as IndexPath],
            with:UITableView.RowAnimation.automatic)
        }
    }
    
}

//textFieldについて
extension TaskViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    // textFieldに値が入力された後の処理
        userDefaults.set(taskArray, forKey: "taskArray")
        userDefaults.synchronize()
        taskArray = userDefaults.object(forKey: "taskArray") as! Array<String>
        //データをリロードする
        self.taskTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // returnキーを押した時の処理
        //textFieldの中身が空の時、警告が出る
        if insertTaskTextField.text == "" {
            showAlert()
            return true
        }
        //textFieldにタスクを入力した時
        if let text = self.insertTaskTextField.text {
        taskArray.append(text)
        self.insertTaskTextField.endEditing(true)
        //キーボードの確定ボタンを押すとテキスト内の文字がリセットされる
        self.insertTaskTextField.text = ""
        }
        //データをリロードする
        self.taskTableView.reloadData()
        return true
    }
    
}
