//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Helen Wang on 3/21/22.
//

import Foundation

class TicTacToeGame : CustomStringConvertible {
    
    var board: [MarkType]
    var state: GameState
    
    enum MarkType : String {    // back these with string
        case x = "X"
        case o = "O"
        case none = "-"
    }
    
    enum GameState: String {
        case xTurn = "X's Turn"
        case oTurn = "O's Turn"
        case xWon = "X Wins!"
        case oWon = "O Wins!"
        case tie = "Tie Game"
    }
    
    init(){
        //        self.board = [MarkType]()
        //        for _ in 0..<9 {
        //            self.board.append(.none)
        //        }
        self.board = [MarkType](repeating: .none, count: 9) // one liner solution
        self.state = .xTurn
    }
    
    
    func pressedSquare(at index: Int){
        if index < 0 || index > 8 {
            print("Invalid Index \(index)")
            return
        }
        if board[index] != .none {
            print("This square is not empty!")
            return
        }
        switch state {
        case .xTurn:
            board[index] = .x
            state = .oTurn  // This is the default that could be overriden later
        case .oTurn:
            board[index] = .o
            state = .xTurn
        default:
            print("This game has already been won. No more moves allowed")
            return
        }
        
        // check for wins
        checkForWin()
    }
    
    func checkForWin() {
        var linesOf3 = [String]()
        
        linesOf3.append(getGameString([0, 1, 2])) // get game string of index 0, 1, 2
        linesOf3.append(getGameString([3, 4, 5]))
        linesOf3.append(getGameString([6, 7, 8]))
        
        linesOf3.append(getGameString([0, 3, 6]))
        linesOf3.append(getGameString([1, 4, 7]))
        linesOf3.append(getGameString([2, 5, 8]))
        
        linesOf3.append(getGameString([0, 4, 8]))
        linesOf3.append(getGameString([2, 4, 6]))
        
        
        for lineOf3 in linesOf3 {
            if lineOf3 == "XXX" {
                state = .xWon
                return
            }
            else if lineOf3 == "OOO" {
                state = .oWon
                return
            }
        }
        
        if(!board.contains(.none)){
            state = .tie
        }
        
    }
    
    func getGameString(_ indicies :[Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]) -> String {
        var gameString = ""
        for index in indicies {
            gameString += self.board[index].rawValue
        }
        return gameString
    }
    
    var description: String {
        return "\(self.state.rawValue) \(getGameString())"
    }
    
    
}
