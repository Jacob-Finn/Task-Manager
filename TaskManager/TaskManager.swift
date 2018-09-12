//
//  TaskManager.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

class TaskManager {
    
    private static var taskArray: [Task] = [
        Task(title: "Get food", description: "Get food from Mcdonald's", completeByDate: nil),
        Task(title: "Get laundry", description: "From the dryer!", completeByDate: nil),
        Task(title: "I am debug", description: "Debugging since 1998", completeByDate: nil)
    ]
    
    static func changeCompletion() {
        print("Please select which task you would like to change the completion status on: ")
        printAllTasks()
        let UserInput = (InputManager.getIndex(taskArray: taskArray) - 1) // Because we print the index with a value of +1, we need to -1.
        let selectedTask = taskArray[UserInput]
        print("Selected - \(selectedTask.title): \(selectedTask.description)\n")
        }
    
    
    
    
    
    
    
    
    static func printCompletedTasks() {
        var completedTasks = [Task]()
        for task in taskArray {
            if task.isComplete == true {
                completedTasks.append(task)
            }
        }
        for (index,task) in completedTasks.enumerated() {
            if task.completeByDate == nil {
                print("\(index + 1). \(task.title): \(task.description)")
            }else {
                print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString)")
            }
        }
    }
    
    
    static func printUncompleteTasks() {
        var uncompletedTasks = [Task]()
        for task in taskArray {
            if task.isComplete == false {
                uncompletedTasks.append(task)
            }
        }
        for (index,task) in uncompletedTasks.enumerated() {
            if task.completeByDate == nil {
                print("\(index + 1). \(task.title): \(task.description)")
            }else {
                print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString)")
            }
        }
    }
    


    
    
    
    static func printAllTasks() {
        for (index,task) in taskArray.enumerated() {
            if task.completeByDate == nil {
                print("\(index + 1). \(task.title): \(task.description)")
            }else {
                print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString)")
            }
        }
    }
    
    
    
    
    
}
