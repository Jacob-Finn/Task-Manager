    //
//  Menu.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation
    class Menu {
        var hasQuit = false
        func start () {
            print("""
                Welcome to the task manager!
                Please enter the corresponding number for your selection.
                1. Create a task.
                2. Delete a task.
                3. Change a task's completion.
                4. Show all tasks
                5. Show completed tasks
                6. Show uncomplete tasks.
                7. Menu commands
                8. Exit
                """)
            repeat {
                checkInput()
            }while !hasQuit
        }
        
        func checkInput() {
            
        }
        
        
        
        
    }
