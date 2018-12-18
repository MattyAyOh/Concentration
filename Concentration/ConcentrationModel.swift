//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

struct ConcentrationModel {
   var pairNumToImage: [Int:UIImage?]
   var completedTilePairs: Set<Int>
   var tilePlacementInGrid: [Int] // Shouldn't have more than 2 of the same number
   
   init(numPairs:Int, images:[UIImage]) {
      var numToImage = [Int:UIImage?]()
      var tileNumbers = [Int]() //Used for Tile Placements
      for i in 0..<numPairs {
         if i < images.count  {
            numToImage[i] = images[i]
         } else {
            numToImage[i] = nil as UIImage?
         }
         tileNumbers.append(contentsOf: [i,i])
      }
      tileNumbers.shuffle()
      self.tilePlacementInGrid = tileNumbers
      self.pairNumToImage = numToImage
      self.completedTilePairs = Set<Int>()
   }
   
   func numTiles() -> Int {
      return tilePlacementInGrid.count
   }
}
