//
//  UserDefaults+extension.swift
//  ToDoApp
//
//  Created by 廣瀬舜一 on 2020/04/30.
//  Copyright © 2020 廣瀬舜一. All rights reserved.
//

import Foundation

extension UserDefaults {
    var taskKey:String {
        "taskKey"
    }
    
    //読み取り処理
    func load() -> [Task] {
        guard let loadData = array(forKey: taskKey) else {
            return []
        }
        var tasks: [Task] = []
        
        for element in loadData {
            if let data = element as? Data, let task = try? JSONDecoder().decode(Task.self, from: data) {
                tasks.append(task)
            }
        }
        return tasks
    }
    
    //保存処理
    func save(_ value : Task) {
        var loadData: [Data] = []
        for task in load() {
            if let data = try? JSONEncoder().encode(task) {
                loadData.append(data)
            }
        }
        if let saveData = try? JSONEncoder().encode(value) {
            loadData.append(saveData)
            set(loadData, forKey: taskKey)
        }
    }
    
    //cellの更新
    func update(task: Task, index: Int) {
        var loadData: [Data] = []
        var loadTask: [Task] = load()
        loadTask[index] = task
        for task in loadTask {
            if let data = try? JSONEncoder().encode(task) {
                loadData.append(data)
            }
        }
        set(loadData, forKey: taskKey)
    }
    
    //削除処理
    func delete(task: Task, index: Int) {
        var loadData:[Data] = []
        var deleteTask:[Task] = load()
        deleteTask[index] = task
        for task in deleteTask {
            if (try? JSONEncoder().encode(task)) != nil {
                loadData.remove(at: index)
            }
        }
        set(deleteTask,forKey: taskKey)
        
    }
    
}
