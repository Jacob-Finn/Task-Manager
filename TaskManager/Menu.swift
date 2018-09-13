    //
    //  Menu.swift
    //  TaskManager
    //
    //  Created by Jacob Finn on 9/12/18.
    //  Copyright © 2018 Jacob Finn. All rights reserved.
    //
    
    import Foundation
    let taskManager = TaskManager() // remove me later
    class Menu {
        var hasQuit = false
        func start () {
            TaskManager.loadArray()
            print("""
                Welcome to the task manager!
                Please enter the corresponding number for your selection.
                1. Create a task.
                2. Delete a task.
                3. Change a task's completion.
                4. Show all tasks
                5. Show completed tasks
                6. Show uncomplete tasks.
                7. Edit a task's properties
                8. Menu commands
                9. Exit
                """)
            repeat {
                checkInput()
            }while !hasQuit
        }
        
        func checkInput() {
            let userChoice = InputManager.playerInput(numberOfChoices: 9)
            
            switch userChoice {
            case 1:
                TaskManager.addTask()
            case 2:
                TaskManager.deleteTask()
            // delete a task
            case 3:
                TaskManager.changeCompletion()
            case 4:
                TaskManager.printAllTasks()
            case 5:
                TaskManager.printCompletedTasks()
            // show completed tasks
            case 6:
                TaskManager.printUncompleteTasks()
            // show uncomplete tasks
            case 7:
                TaskManager.editTask()
            case 8:
                help()
            case 9:
                quit()
            default:
                break
            }
        }
        
        
        
        
        
        
        
        
        
        func help() {
            print("""
                Welcome to the task manager!
                Please enter the corresponding number for your selection.
                1. Create a task.
                2. Delete a task.
                3. Change a task's completion.
                4. Show all tasks
                5. Show completed tasks
                6. Show uncomplete tasks.
                7. Edit a task's properties
                8. Menu commands
                9. Exit
                """)
        }
        func quit() {
            TaskManager.saveArray()
            exit(25)
        }
        
        
        
    }
