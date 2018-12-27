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
   let totalTime:Int
   let movesMade:Int
   let totalPairs:Int
   
   init(dateCompleted:Date, timePassed:Int, movesMade:Int, totalPairs:Int) {
      let formatter = DateFormatter()
      formatter.dateFormat = "MMM dd, yyyy (HH:mm)"
      self.dateCompleted = formatter.string(from: dateCompleted)
      
      self.movesMade = movesMade
      self.totalTime = timePassed
      self.totalPairs = totalPairs
   }
   
   func minutesTaken() -> String {
      return self.totalTime.inMinutes()
   }
   
   func secondsTaken() -> String {
      return self.totalTime.inSeconds()
   }
}
