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
    
    static func addTask() {
        print("Please enter the title of your task.")
        var inputedTaskTitle: String? = nil
        repeat {
            let userInput = readLine()
            if userInput == "" {
                print("Please enter a valid title")
                inputedTaskTitle = nil
            }else {
                inputedTaskTitle = userInput!
            }
        } while inputedTaskTitle == nil
        print("Please enter the description of your task (optional)")
        let inputedTaskDescription = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Please enter how many days you would like this task completed in.\nUse -1 for no day set.")
        var daysToAdd: Int? = nil
        repeat {
            let userInput = readLine()
            guard let userInt = Int(userInput!) else {
                print("Please use a valid number!")
                return
            }
            if userInt < -1 {
                print("Not a valid number")
                return
            }else {
                daysToAdd = userInt
            }
        } while daysToAdd == nil
        print(  """
                Please enter the priority of this task.
                1. Standard
                2. Important
                3. Critical
                """)
        var inputedPriority: Priority
        let userInput = InputManager.playerInput(numberOfChoices: 3)
        switch userInput {
        case 1:
            inputedPriority = .Standard
        case 2:
            inputedPriority = .Important
        case 3:
            inputedPriority = .Critical
        default:
            inputedPriority = .Standard
        }
        
        let task = Task(title: inputedTaskTitle!, description: inputedTaskDescription!, priority: inputedPriority, completeByDate: nil)
        if(daysToAdd != -1) {
            task.setDate(days: daysToAdd!)
        }
        taskArray.append(task)
        print("task \(task.title) has been created")
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
        sortTasks()
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
        sortTasks()
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
    
    static func sortTasks() {
        taskArray.sort(by: { $0.priority.rawValue > $1.priority.rawValue})
    }
    
    
    
    
    static func printAllTasks() {
        sortTasks()
        for (index,task) in taskArray.enumerated() {
            if task.completeByDate == nil {
                if task.isComplete
                {
                    print("\(index + 1). \(task.title): \(task.description) Status: Completed")
                }else {
                    print("\(index + 1). \(task.title): \(task.description) Status: Incomplete")
                }
            }else {
                if task.isComplete {
                    print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString) Status: Completed")
                }else {
                    print("\(index + 1). \(task.title): \(task.description)| \(task.completeByDateString) Status: Incomplete")
                }
            }
        }
    }
    
    
    
    
    
}
