//
//  Game.swift
//  Buzzer
//
//  Created by Asma Harbi on 2016-05-04.
//  Copyright © 2016 Asma Harbi. All rights reserved.
//

import Foundation

class Game{
    
    var player1 : Player?
    var player2 : Player?
    var player3 : Player?
    var currentPlayer: Player?
    
    var questions: [Question] = []
    var currentQuestion: Question?
    var categories: [Category] = []
    
    

func loadCategoriesForNewGame() {
    do {
        categories = try Category.loadCategories()
    }
    catch let error {
        print("Error loading categories: \(error)")
    }
}
    
    func loadCategoriesForNewGame(numberOfCategories: Int, responseActionHandler : (error : NSError?) -> ()) {
        Category.loadCategories(numberOfCategories, responseHandler: { (error, items) -> () in
            self.categories = items!
            
            if let categoriesArray = items {
                self.categories = categoriesArray
            }
            
            responseActionHandler(error: error)
            
        })
    }

    func currentPlayerGotItRight() {
        guard let currentPlayer = currentPlayer else {
            return }
        if let price = currentQuestion?.price {
            currentPlayer.score += price
        }
        
    }

    func currentPlayerGotItWrong() {
        guard let currentPlayer = currentPlayer else {
            return }
        if let price = currentQuestion?.price {
            currentPlayer.score -= price
        }
        
    }
    

}

 