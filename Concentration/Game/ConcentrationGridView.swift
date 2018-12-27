//
//  ConcentrationGridView.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

protocol GridViewDelegate: NSObjectProtocol {
   func pairGuessed()
   func pairFound(_ pairNum:Int)
}

class ConcentrationGridView: UIView, TileDelegate {
   var tiles: [ConcentrationTile] = []
   var firstChosenTile:ConcentrationTile?
   private var hideCompletedPairs = false
   
   weak var delegate:GridViewDelegate?
   
   func loadFromModel(_ model:GameModel) {
      self.backgroundColor = UIColor.clear
      addTiles(model.numTiles())
      for i in 0..<tiles.count {
         let pairNum = model.tilePlacementInGrid[i]
         if model.useImageTiles, let tileImage = K.pairNumToImage[pairNum] {
            tiles[i].updateTile(withNewNum: pairNum, andNewImage: tileImage)
         } else {
            tiles[i].updateTile(withNewNum: pairNum, andNewImage: nil)
         }
         if model.completedTilePairs.contains(pairNum) {
            tiles[i].flipTile()
            if model.hideCompletedPairs {
               tiles[i].isHidden = true
            } else {
               tiles[i].backgroundColor = K.correctGuessColor
            }
         }
      }
      hideCompletedPairs = model.hideCompletedPairs
   }
   
   private func addTiles(_ numTiles: Int) {
      tiles.removeAll()
      let sideLength = determineTileSideSize(forNumTiles: Double(numTiles))
      
      let tilesInRow = Int(Double(self.frame.width)/sideLength)

      var tilesCreated = 0
      var rowNum = 0
      while tilesCreated < numTiles {
         for colNum in 0..<tilesInRow {
            let yOffset = Double(rowNum)*sideLength
            let xOffset = Double(colNum)*sideLength
            let newTile = ConcentrationTile(frame: CGRect.init(x: xOffset, y: yOffset, width: sideLength, height: sideLength), delegate:self)
            self.addSubview(newTile)
            tiles.append(newTile)
            tilesCreated += 1
            if tilesCreated == numTiles {
               break
            }
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

   func tileFlipped(_ tile: ConcentrationTile) {
      if firstChosenTile == nil {
         firstChosenTile = tile
      } else {
         delegate?.pairGuessed()
         if firstChosenTile?.pairNumber == tile.pairNumber {
            delegate?.pairFound(tile.pairNumber)
            let firstTile = self.firstChosenTile
            if hideCompletedPairs {
               tile.backgroundColor = K.correctGuessColor
               firstTile?.backgroundColor = K.correctGuessColor
               DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                  tile.isHidden = true
                  firstTile?.isHidden = true
               }
            } else {
               UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                  tile.backgroundColor = K.correctGuessColor
                  firstTile?.backgroundColor = K.correctGuessColor
               }, completion: nil)
            }
            self.firstChosenTile = nil
         } else {
            tile.wrongGuessKeepFlipped()
            firstChosenTile?.wrongGuessKeepFlipped()
            self.firstChosenTile = nil
         }
         
      }
   }
   
   func resetGuessedTiles() {
      let wrongTiles = tiles.filter{$0.isShowingWrongGuess}
      for tile in wrongTiles {
         tile.unflipTile()
      }
   }
}
