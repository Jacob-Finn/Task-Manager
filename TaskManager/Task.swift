//
//  Task.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation
enum Priority: Int, Codable {
    case Standard = 1
    case Important = 2
    case Critical = 3
}

class Task: NSObject, NSCoding {
    
    var title: String
    var taskDescription: String
    var isComplete: Bool
    var completeByDate: Date?
    var completeByDateString: String
    var priority: Priority
    
    
    init(title: String, description: String, completeByDate: Date?) {
        self.title = title
        self.taskDescription = description
        self.isComplete = false
        self.priority = .Standard
        self.completeByDate = completeByDate
        self.completeByDateString = ""
    }
    
    init(title: String, description: String, priority: Priority, completeByDate: Date?) {
        self.title = title
        self.taskDescription = description
        self.isComplete = false
        self.priority = priority
        self.completeByDate = completeByDate
        self.completeByDateString = "" // Get sets when the setDate function is ran
    }
    
    init(title: String, description: String, priorityRawValue: Int, completeByDate: Date?, isComplete: Bool, completeByDateString: String) { //init used for loading a save.
        self.title = title
        self.taskDescription = description
        self.isComplete = isComplete
        self.priority = Priority(rawValue: priorityRawValue)!
        self.completeByDate = completeByDate
        self.completeByDateString = completeByDateString
    }
    
    
    
    
    func changeCompletion(to isComplete: Bool) {
        self.isComplete = isComplete
    }
    
    func setDate(days timeToAdd: Int) {
        if timeToAdd != -1 { // In my TaskManager.addTask method, we use -1 to show that there is no due date.
            let dateFormatter = DateFormatter()
            let calander = Calendar(identifier: .gregorian)
            let today = Date()
            let calculatedDate = calander.date(byAdding: .day, value: timeToAdd, to: today)
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dueDateString = dateFormatter.string(from: calculatedDate!)
            self.completeByDateString = dueDateString
            self.completeByDate = calculatedDate!
        }else {
            self.completeByDate = nil
            self.completeByDateString = ""
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title , forKey: "title")
        aCoder.encode(self.taskDescription, forKey: "taskDescription")
        aCoder.encode(self.isComplete, forKey: "isComplete")
        aCoder.encode(self.completeByDateString, forKey: "completeByDateString")
        aCoder.encode(self.completeByDate, forKey: "completeByDate")
        aCoder.encode(self.priority.rawValue, forKey: "priority")
    }
    
    
    convenience required init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let taskDescription = aDecoder.decodeObject(forKey: "taskDescription") as! String
        let isComplete = aDecoder.decodeBool(forKey: "isComplete")
        let completeByDateString = aDecoder.decodeObject(forKey: "completeByDateString") as! String
        let completeByDate = aDecoder.decodeObject(forKey: "completeByDate") as! Date?
        let priority = aDecoder.decodeInteger(forKey: "priority")
        self.init(title: title, description: taskDescription, priorityRawValue: priority, completeByDate: completeByDate, isComplete: isComplete, completeByDateString: completeByDateString)
        
    }
    
    
    
    func setTitle(to newTitle: String) {
        self.title = newTitle
    }
    func setDescription(to newDescription: String) {
        self.taskDescription = newDescription
    }
    func setPriority(to newPriority: Priority) {
        self.priority = newPriority
    }
    
    
    
}
