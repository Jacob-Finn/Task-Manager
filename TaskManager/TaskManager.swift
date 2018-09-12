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
    
    private static func checkForEmpty() { // If the array is empty we don't want to force the users into a loop!
        if taskArray.count == 0 {
            print("No tasks found! Please make another selection.")
            menu.checkInput()
        }
    }
    
    
    static func changeCompletion() {
        checkForEmpty()
        print("Please select which task you would like to change the completion status on: ")
        printAllTasks()
        var userInput = (InputManager.getIndex(taskArray: taskArray) - 1) // Because we print the index with a value of +1, we need to -1.
        let selectedTask = taskArray[userInput]
        print(  """
            Selected - \(selectedTask.title): \(selectedTask.description) \(selectedTask.isComplete)
            Please enter the corresponding value to change completion.
            1. Complete
            2. Uncomplete
            """)
        userInput = InputManager.playerInput(numberOfChoices: 2)
        if userInput == 1 {
            selectedTask.changeCompletion(to: true)
            print("\(selectedTask.title) is now completed\n")
        } else if userInput == 2 {
            selectedTask.changeCompletion(to: false)
            print("\(selectedTask.title) is now uncompleted.\n")
        }
    }
    
    static func deleteTask() {
        checkForEmpty()
        print("Please select which task you would like to delete.")
        printAllTasks()
        let userInput = (InputManager.getIndex(taskArray: taskArray) - 1)
        print("Removing \(taskArray[userInput].title)")
        taskArray.remove(at: userInput)
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
                if task.isComplete
                {
                    print("\(index + 1). \(task.title): \(task.description) Status: Completed")
                }else {
                    print("\(index + 1). \(task.title): \(task.description) Status: Uncomplete")
                }
            }else {
                if task.isComplete {
                    print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString) Status: Completed")
                }else {
                    print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString) Status: Uncomplete")
                }
            }
        }
    }
    
    
    
    
    
}
