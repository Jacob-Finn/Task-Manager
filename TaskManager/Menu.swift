    //
    //  Menu.swift
    //  TaskManager
    //
    //  Created by Jacob Finn on 9/12/18.
    //  Copyright © 2018 Jacob Finn. All rights reserved.
    //
    
    import Foundation
    
    class Menu {
        let userDefaults = UserDefaults()
        var hasQuit = false
        func start () {
            checkPassword()
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
        
        
        func checkPassword() {
            
            let userDefaults = UserDefaults()
            guard let userPassword = userDefaults.object(forKey: "password") as! String? else {
                return createPassword()
            }
            var passwordCorrect = false
            print("Please enter your password")
            repeat {
                let userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
                if userInput == userPassword {
                    print("Password correct!")
                    passwordCorrect = true
                }
                else {
                    print("Invalid password")
                    passwordCorrect = false
                }
            } while !passwordCorrect
            
        }
        func createPassword() {
            
            var userPassword: String
            print("No password found, starting creation.")
            var selectionMade = false
            repeat {
                print("Please enter your new password.")
                var userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
                print("Password set is '\(userInput!)' is this correct?\nyes or no?")
                userPassword = userInput!
                userInput = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
                if userInput?.lowercased() == "yes" {
                    print("Password is correct.")
                    userDefaults.set(userPassword, forKey: "password")
                    selectionMade = true
                }else if userInput?.lowercased() == "no" {
                    print("Returning to creation.")
                    selectionMade = false
                }else {
                    print("Invalid input. Returning to creation.")
                    selectionMade = false
                }
            } while !selectionMade
            checkPassword()
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
