//
//  taskTableViewCell.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/22.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import UIKit


class taskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    var task:Task?
    var index: Int?
//    var isImportant = UIImage(named: "importantTask.png")
//    var isNotImportant = UIImage(named: "notImportantTask.png")
    
    //フラグを定義
    var flg = false


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setup(task: Task, index: Int) {
        taskLabel.text = task.contents
        if task.isImportant {
            favoriteButton.setImage(#imageLiteral(resourceName: "importantTask"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "notImportantTask"), for: .normal)
        }
        self.task = task
        self.index = index
    }
    
    @IBAction func addFavoriteTaskButton(_ sender: UIButton) {
        //ボタンの画像を切り替える処理
        //重要タスクを追加する処理
        guard let task = task, let index = index else {
            return
        }
        if task.isImportant {
            favoriteButton.setImage(#imageLiteral(resourceName: "notImportantTask"), for: .normal)
            task.isImportant = false
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "importantTask"), for: .normal)
            task.isImportant = true
        }
        UserDefaults.standard.update(task: task, index: index)
    }
    
    
    }


    
    
    

