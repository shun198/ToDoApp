//
//  taskTableViewCell.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/22.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import UIKit

protocol taskTableViewCellDelegate {
    func didAddFavoriteTask(task:String)
}

class taskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    
    var task:Task?
    var delegate:taskTableViewCellDelegate?
    var isImportant = UIImage(named: "importantTask.png")
    var isNotImportant = UIImage(named: "notImportantTask.png")
    
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
    
    
    @IBAction func addFavoriteTaskButton(_ sender: UIButton) {
        //ボタンの画像を切り替える処理
        //重要タスクを追加する処理
        if flg == false {
            favoriteButton.setImage(isImportant, for: .normal)
            flg = true
            print("false")
        } else if flg == true {
            favoriteButton.setImage(isNotImportant, for: .normal)
            flg = false
            print("true")
            }
        }
    
    
    }


    
    
    

