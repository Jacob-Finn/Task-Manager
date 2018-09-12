//
//  Task.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

class Task {
    
    var title: String
    var description: String
    var isComplete: Bool
    var completeByDate: Date?
    var completeByDateString: String
    
    init(title: String, description: String, completeByDate: Date?) {
        self.title = title
        self.description = description
        self.isComplete = false
        self.completeByDate = completeByDate
        completeByDateString = "" // Change this later to do a computation function.
    }
    func changeCompletion(to isComplete: Bool) {
        self.isComplete = isComplete
    }
    
    
}
