//
//  GameModel.swift
//  TagGameApp
//
//  Created by Michael Shustov on 09.12.2021.
//

import Foundation
import UIKit

enum GameChip: Equatable {
    case button(Int)
    case emptySpace
}

class GameModel {

    // MARK: - Properties and variables
    
    var board2d = Array(repeating: Array(repeating: GameChip.emptySpace, count: 4), count: 4)
    
    init() {
        
        self.redrawBoard()
    }

    func redrawBoard() {
        
        // Initialize an array of game chips
        var board = [GameChip]()
        
        // Fill the array with numbers
        (1...15).forEach { number in
            
            board.append(.button(number))
        }
        
        // Shuffle the array
        board.shuffle()
        
        // Insert empty game chip as the first item of the array
        board.insert(.emptySpace, at: 0)
        
        var counter = 0
        
        // Fill the 2d array with prepared game chips
        for i in 0..<board2d.count {
            for j in 0..<board2d[i].count {
                
                board2d[i][j] = board[counter]
                
                counter += 1
            }
        }
    }
    
    func moveChip(chip: GameChip) -> Bool {
        
        switch chip {
        case .button:
            
            var chipRow = 0
            var chipColumn = 0
            var emptyRow = 0
            var emptyColumn = 0
            
            // Get positions of the tapped and empty chips
            for row in 0..<board2d.count {
                for column in 0..<board2d[row].count {
                    
                    if chip == board2d[row][column] {
                        chipRow = row
                        chipColumn = column
                        print("chipRow: \(chipRow)")
                        print("chipColumn: \(chipColumn)")
                    }
                    
                    if GameChip.emptySpace == board2d[row][column] {
                        emptyRow = row
                        emptyColumn = column
                        print("emptyRow: \(emptyRow)")
                        print("emptyColumn: \(emptyColumn)")
                    }
                }
            }
            
            if chipRow == 0 && emptyRow == 0 && chipColumn == 0 && emptyColumn == 0 {
                print("COULDNT COMPARE GAMECHIPS TYPE!")
            }
            
            // Check if tapped and empty chip have common border
            if chipRow == emptyRow && abs(chipColumn - emptyColumn) == 1 {
                
                let tmp = board2d[chipRow][chipColumn]
                board2d[chipRow][chipColumn] = board2d[emptyRow][emptyColumn]
                board2d[emptyRow][emptyColumn] = tmp
                
                return true
            }
            else if chipColumn == emptyColumn && abs(chipRow - emptyRow) == 1 {
                
                let tmp = board2d[chipRow][chipColumn]
                board2d[chipRow][chipColumn] = board2d[emptyRow][emptyColumn]
                board2d[emptyRow][emptyColumn] = tmp
                
                return true
            }
            else {
                return false
            }
            
        case .emptySpace:
            return false
        }
    }
    
    func checkWin() -> Bool {
        
        var winCounter = 0
        var rightNumber = 1
        
        // Check if numbers in array go in right sequence
        for i in 0..<board2d.count {
            for j in 0..<board2d[i].count {
                
                switch board2d[i][j] {
                case .button(let number):
                    if number == rightNumber {
                        
                        rightNumber += 1
                        winCounter += 1
                    }
                    else {
                        break
                    }
                    
                case .emptySpace:
                    break
                }
            }
        }
        
        if winCounter == 15 {
            return true
        }
        else {
            return false
        }
    }
}
