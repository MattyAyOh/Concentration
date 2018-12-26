//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import XCTest
@testable import Concentration

class ConcentrationTests: XCTestCase, GridViewDelegate {
   
   static let numPairs = 24
   var gridView:ConcentrationGridView? = nil
   var backingModel:GameModel? = nil
   
   override func setUp() {
      let model = GameModel(numPairs: ConcentrationTests.numPairs, hideCompletedPairs:false, useImageTiles:false)
      backingModel = model
      gridView = ConcentrationGridView.init(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
      gridView?.loadFromModel(model)
      gridView?.delegate = self
   }
   
   override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   }
   
   func testTileCount() {
      XCTAssert(gridView?.tiles.count == ConcentrationTests.numPairs*2)
   }
   
   func testPlaythrough() {
      guard let numPairs = backingModel?.numPairs() else {XCTAssert(false); return}
      guard let numTiles = gridView?.tiles.count else {XCTAssert(false); return}
      for _ in 0..<numPairs {
         var firstTile: ConcentrationTile? = nil
         for j in 0..<numTiles {
            guard let tile = gridView?.tiles[j] else {continue}
            guard backingModel?.completedTilePairs.contains(tile.pairNumber) == false else {continue}
            if firstTile == nil {
               firstTile = tile
               continue
            }
            
            firstTile?.tileTapped(UITapGestureRecognizer())
            tile.tileTapped(UITapGestureRecognizer())
            if gridView?.showingWrongGuess == true {
               tile.tileTapped(UITapGestureRecognizer())
            }
         }
      }
      
      XCTAssert(backingModel?.completedTilePairs.count == ConcentrationTests.numPairs)
   }
   
   func pairGuessed() {
//      backingModel?.movesMade += 1
   }
   
   func pairFound(_ pairNum: Int) {
      backingModel?.completedTilePairs.insert(pairNum)

      // NOTE: This would be useful for testing the history persistance
//
//      if backingModel?.completedTilePairs.count == backingModel?.numPairs() {
//         let win = HistoryModel(dateCompleted: Date(), timePassed: (self.backingModel?.secondsPassed ?? 0), movesMade: (self.backingModel?.movesMade ?? 0), totalPairs:(self.backingModel?.numPairs() ?? 0))
//         self.backingModel = nil
//      }
   }
   
}
