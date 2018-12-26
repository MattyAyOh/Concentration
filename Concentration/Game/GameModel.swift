//
//  GameModel.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

struct GameModel:Codable {
   var completedTilePairs: Set<Int>
   var tilePlacementInGrid: [Int] // Shouldn't have more than 2 of the same number
   var secondsPassed:Int
   var movesMade:Int
   
   var hideCompletedPairs:Bool
   var useImageTiles:Bool
   
   init(numPairs:Int, hideCompletedPairs:Bool, useImageTiles:Bool) {
      var tileNumbers = [Int]() //Used for Tile Placements
      for i in 0..<numPairs {
         tileNumbers.append(contentsOf: [i,i])
      }
      tileNumbers.shuffle()
      self.tilePlacementInGrid = tileNumbers
      self.completedTilePairs = Set<Int>()
      
      self.secondsPassed = 0
      self.movesMade = 0
      
      self.hideCompletedPairs = hideCompletedPairs
      self.useImageTiles = useImageTiles
   }
   
   func numTiles() -> Int {
      return tilePlacementInGrid.count
   }
   
   func numPairs() -> Int {
      return tilePlacementInGrid.count/2
   }
}
