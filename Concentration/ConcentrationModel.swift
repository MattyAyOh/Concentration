//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

struct TileData:Hashable {
   let pairNumber: Int
   let image: UIImage?
   var hashValue: Int {
      return pairNumber
   }
}

struct ConcentrationModel {
   var tiles: Set<TileData>
   var completedTilePairs: Set<Int>
   var tilePlacementInGrid: [Int] // Shouldn't have more than 2 of the same number
   
   init(numPairs:Int, images:[UIImage]) {
      var newTiles = Set<TileData>()
      var tileNumbers = [Int]() //Used for Tile Placements
      for i in 0..<numPairs {
         newTiles.insert(TileData(pairNumber: i, image: images[i]))
         tileNumbers.append(contentsOf: [i,i])
      }
      tileNumbers.shuffle()
      self.tilePlacementInGrid = tileNumbers
      self.tiles = newTiles
      self.completedTilePairs = Set<Int>()
   }
   func numPairs() -> Int {
      return tiles.count
   }
}
