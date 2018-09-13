//
//  InputManager.swift
//  TaskManager
//
//  Created by Jacob Finn on 9/12/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

private var userInput: String?
private var selectionMade = false

class InputManager {
    
    static func playerInput (numberOfChoices: Int) -> Int {
        repeat {
            userInput = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
            if userInput?.lowercased() == "clear" { // a helpful function if the console is starting to get too cluttered.
                print("\n\n\n\n\n\n\n\n\n\n")
                break;
            }
            if userInput?.lowercased() == "help" {
                menu.help()
            } else if let userInput = Int(userInput!) {
                if (userInput <= 0) {
                    print("Did you really think that would work?") // Entering a negative number gives you a specific response. Kind of sarcastic.
                    continue
                }
                if (userInput > numberOfChoices) {
                    print("Not a valid option! There are only \(numberOfChoices) choices!")
                    continue
                }
                selectionMade = true
                return userInput
            }else {
                print("Not a valid selection!")
            }
        } while !selectionMade
        return -3 // Error return
    }
    
    
    static func getIndex(taskArray: [Task]) -> Int {
        var userInput: Int? = nil
        repeat {
            userInput = InputManager.playerInput(numberOfChoices: taskArray.count)
            if userInput == -3 {
                userInput = nil
            }
        } while userInput == nil
        return userInput!
    }
    
    // Line 49 - Since the InputManager.playerInput will return an error value of -3 if the number isn't allowed we can use this error value
    // to determine if a number has been set or not. Also -3 will never be returned by default.
    
    static func getRealNumber() -> Int {
        var userInput: String? = nil
        var allowedNumber = 0
        repeat {
            userInput = readLine()
            guard let userInt = Int(userInput!) else {
                print("Please use a real number!")
                userInput = nil
                continue
            }
            if userInt < -1 {
                print("Invalid number!")
                userInput = nil
                continue
            }else {
                allowedNumber = userInt
            }
            
        } while userInput == nil
        return allowedNumber
    }
    
    
}


