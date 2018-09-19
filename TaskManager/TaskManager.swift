//
//  TaskManager.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

class TaskManager {
    let userDefaults = UserDefaults.standard
    
    
    // Most of the functions here are Static as the TaskManager is not really an object per say, and there should only ever should be one list that we're working with. Using a static function achieves this goal.
    
    private static var taskArray: [Task] = [
        Task(title: "Debug code", description: "Still debugging", priority: .Critical, completeByDate: nil)
    ]
    
    
    static func saveArray() {
        let taskArray = TaskManager.taskArray
        let taskArrayData = NSKeyedArchiver.archivedData(withRootObject: taskArray)
        UserDefaults.standard.set(taskArrayData, forKey: "taskArray")
        
    }
    static func loadArray() {
        guard let taskArrayData = UserDefaults.standard.value(forKey: "taskArray") else {
            return
        }
        let taskArray = NSKeyedUnarchiver.unarchiveObject(with: taskArrayData as! Data)
        TaskManager.taskArray = taskArray as! [Task]
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
        print("Please enter how many days you would like this task completed in.\nUse -1 for no day set and 0 if you would like today to be the due date.")
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
        task.setDate(days: daysToAdd!)
        taskArray.append(task)
        saveArray()
        print("task \(task.title) has been created\n")
    }
    
    // Edit task uses a lot of switch statements in order to simplify selection.
    static func editTask() {
        if taskArray.count != 0 {
            TaskManager.printAllTasks()
            print("Which task would you like to edit?")
            var userInput = InputManager.getIndex(taskArray: taskArray)
            let selectedTask = taskArray[userInput - 1] // subtract 1 since index is shown with +1
            print(  """
                What would you like to edit?
                1. Title
                2. Description
                3. Task due date
                4. Priority
                """)
            userInput = InputManager.playerInput(numberOfChoices: 4)
            switch userInput {
            case 1:
                print("Please enter the new title")
                let userInput = readLine()
                selectedTask.setTitle(to: userInput!)
                print("Title has been changed.")
            case 2:
                print("Please enter your new description")
                let userInput = readLine()
                selectedTask.setDescription(to: userInput!)
                print("Description has been changed.")
            case 3:
                print("Please enter the new due date.\nRemember that -1 removes the due date and 0 will set the due date to today.")
                let userInput = InputManager.getRealNumber()
                selectedTask.setDate(days: userInput)
                print("Date has been changed.")
            case 4:
                print(  """
                Please enter the priority of this task.
                1. Standard
                2. Important
                3. Critical
                """)
                let userInput = InputManager.playerInput(numberOfChoices: 3)
                switch userInput {
                case 1:
                    selectedTask.setPriority(to: .Standard)
                    print("Priority has been changed.")
                case 2:
                    selectedTask.setPriority(to: .Important)
                    print("Priority has been changed.")
                case 3:
                    selectedTask.setPriority(to: .Critical)
                    print("Priority has been changed.")
                default:
                    selectedTask.setPriority(to: .Standard)
                    print("Priority has been changed.")
                }
            default:
                break
            }
        }else {
            print("No tasks to edit!")
            
        }
    }
    
    
    
    static func changeCompletion() {
        if taskArray.count != 0 {
            print("Please select which task you would like to change the completion status on: ")
            printAllTasks()
            var userInput = (InputManager.getIndex(taskArray: taskArray) - 1) // Because we print the index with a value of +1, we need to -1.
            let selectedTask = taskArray[userInput]
            print(  """
                Selected - \(selectedTask.title): \(selectedTask.taskDescription) \(selectedTask.isComplete)
                Please enter the corresponding value to change completion.
                1. Complete
                2. Uncomplete
                """)
            userInput = InputManager.playerInput(numberOfChoices: 2)
            if userInput == 1 {
                selectedTask.changeCompletion(to: true)
                print("\(selectedTask.title) is now completed\n")
                saveArray()
            } else if userInput == 2 {
                selectedTask.changeCompletion(to: false)
                print("\(selectedTask.title) is now uncompleted.\n")
                saveArray() // I often call my save function after creating something new, just in case the user stops the program instead of ending it VIA quit like they should.
            }
        } else {
            print("No tasks to change completion on.")
        }
    }
    
    // Delete a task at the index and then save the array.
    static func deleteTask() {
        if taskArray.count != 0 {
            print("Please select which task you would like to delete.")
            printAllTasks()
            let userInput = (InputManager.getIndex(taskArray: taskArray) - 1)
            print("Removing \(taskArray[userInput].title)")
            taskArray.remove(at: userInput)
            saveArray()
        }else {
            print("No tasks to delete.")
        }
    }
    
    // Sort the tasks by their priorities raw value. higher numbers go on top.
    static func sortTasks() {
        taskArray.sort(by: { $0.priority.rawValue > $1.priority.rawValue})
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
                print("\(index + 1). \(task.title): \(task.taskDescription)")
            }else {
                print("\(index + 1). \(task.title): \(task.taskDescription)| \(task.completeByDateString)")
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
                print("\(index + 1). \(task.title): \(task.taskDescription)")
            }else {
                print("\(index + 1). \(task.title): \(task.taskDescription)| \(task.completeByDateString)")
            }
        }
    }
    
    
    static func printAllTasks() {
        sortTasks()
        for (index,task) in taskArray.enumerated() {
            if task.completeByDate == nil {
                if task.isComplete
                {
                    print("\(index + 1). Priority: \(task.priority)| \(task.title): \(task.taskDescription) Status: Completed")
                }else {
                    print("\(index + 1). Priority: \(task.priority)| \(task.title): \(task.taskDescription) Status: Incomplete")
                }
            }else {
                if task.isComplete {
                    print("\(index + 1). Priority: \(task.priority)| \(task.title): \(task.taskDescription) |\(task.completeByDateString)| Status: Completed")
                }else {
                    print("\(index + 1). Priority: \(task.priority)| \(task.title): \(task.taskDescription) |\(task.completeByDateString)| Status: Incomplete")
                }
            }
        }
    }
}
