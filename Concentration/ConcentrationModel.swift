//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

struct ConcentrationModel:Codable {
   var completedTilePairs: Set<Int>
   var tilePlacementInGrid: [Int] // Shouldn't have more than 2 of the same number
   var secondsPassed:Int
   var movesMade:Int
   
   init(numPairs:Int) {
      var tileNumbers = [Int]() //Used for Tile Placements
      for i in 0..<numPairs {
         tileNumbers.append(contentsOf: [i,i])
      }
      tileNumbers.shuffle()
      self.tilePlacementInGrid = tileNumbers
      self.completedTilePairs = Set<Int>()
      
      self.secondsPassed = 0
      self.movesMade = 0
   }
   
   func numTiles() -> Int {
      return tilePlacementInGrid.count
   }
   
   func numPairs() -> Int {
      return tilePlacementInGrid.count/2
   }
   
   //MARK: - Codable
   
   enum CodingKeys: String, CodingKey {
      case completedTilePairs
      case tilePlacementInGrid
      case secondsPassed
      case movesMade
   }
   
   func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(completedTilePairs, forKey: .completedTilePairs)
      try container.encode(tilePlacementInGrid, forKey: .tilePlacementInGrid)
      try container.encode(secondsPassed, forKey: .secondsPassed)
      try container.encode(movesMade, forKey: .movesMade)
   }
   
   public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.completedTilePairs = try container.decode(Set<Int>.self, forKey: .completedTilePairs)
      self.tilePlacementInGrid = try container.decode([Int].self, forKey: .tilePlacementInGrid)
      self.secondsPassed = try container.decode(Int.self, forKey: .secondsPassed)
      self.movesMade = try container.decode(Int.self, forKey: .movesMade)
   }
   
}
