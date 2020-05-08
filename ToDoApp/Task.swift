//
//  Task.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/30.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import Foundation

//保存対象のカスタムクラス
class Task :Codable {
    
    var contents:String
    var isImportant = false
    init(task:String) {
        self.contents = task
    }
}
