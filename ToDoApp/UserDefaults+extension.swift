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
    func delete(index: Int) {
        var loadData: [Data] = []
        var deleteTask:[Task] = load()
        deleteTask.remove(at: index)
        for task in deleteTask {
            if let data = try? JSONEncoder().encode(task) {
                loadData.append(data)
            }
        }
        set(loadData, forKey: taskKey)
    }
    

    func loadImportantTask() -> [Task] {
        guard let loadData = array(forKey: taskKey) else {
            return []
        }
        var tasks: [Task] = []
        
            for element in loadData {
                if let data = element as? Data, let task = try? JSONDecoder().decode(Task.self, from: data) {
                    if task.isImportant {
                    tasks.append(task)
                    }
                }
            }
        return tasks
    }

}
