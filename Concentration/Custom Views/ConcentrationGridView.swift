//
//  ConcentrationGridView.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class ConcentrationGridView: UIView {
   
   func addTiles(_ numTiles: Int) {
      let sideLength = determineTileSideSize(forNumTiles: Double(numTiles))
      
      let tilesInRow = Int(Double(self.frame.width)/sideLength)

      var tilesCreated = 0
      var rowNum = 0
      while tilesCreated < numTiles {
         for colNum in 0..<tilesInRow {
            let yOffset = Double(rowNum)*sideLength
            let xOffset = Double(colNum)*sideLength
            let newTile = ConcentrationTile(frame: CGRect.init(x: xOffset, y: yOffset, width: sideLength, height: sideLength))
            self.addSubview(newTile)
            tilesCreated += 1
         }
         rowNum += 1
      }

   }
   
   fileprivate func determineTileSideSize(forNumTiles N: Double) -> Double {
      let width = Double(self.frame.width)
      let height = Double(self.frame.height)
      
      var i:Double = round(sqrt(N*width/height))
      var j:Double = round(sqrt(N*height/width))
      while i*floor(height*i/width) < N {
         i += 1
      }
      while floor(width*j/height) < N {
         j += 1
      }
      return max(width/i, height/j)
   }
}
