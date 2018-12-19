//
//  HistoryModel.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

struct HistoryModel: Codable {
   let dateCompleted:String
   // Decided to store Minutes and Seconds separately, though we easily could compute this at runtime
   let minutesCompleted:Int
   let secondsCompleted:Int
   let totalTime:Int
   let movesMade:Int
   let totalPairs:Int
   
   init(dateCompleted:Date, timePassed:Int, movesMade:Int, totalPairs:Int) {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd-MMM-yyyy"
      self.dateCompleted = formatter.string(from: dateCompleted)
      
      self.movesMade = movesMade
      self.minutesCompleted = timePassed / 60
      self.secondsCompleted = timePassed % 60
      self.totalTime = timePassed
      self.totalPairs = totalPairs
   }
   
}
