//
//  Task.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation
enum Priority: Int {
    case Standard = 1
    case Important
    case Critical
}

class Task {
    
    var title: String
    var description: String
    var isComplete: Bool
    var completeByDate: Date?
    var completeByDateString: String
    var priority: Priority
    
    
    init(title: String, description: String, completeByDate: Date?) {
        self.title = title
        self.description = description
        self.isComplete = false
        self.priority = .Standard
        self.completeByDate = completeByDate
        completeByDateString = ""
    }
    
    init(title: String, description: String, priority: Priority, completeByDate: Date?) {
        self.title = title
        self.description = description
        self.isComplete = false
        self.priority = priority
        self.completeByDate = completeByDate
        completeByDateString = "" // Get sets when the setDate function is ran
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
    func setTitle(to newTitle: String) {
        self.title = newTitle
    }
    func setDescription(to newDescription: String) {
        self.description = newDescription
    }
    func setPriority(to newPriority: Priority) {
        self.priority = newPriority
    }
    
    
    
}
