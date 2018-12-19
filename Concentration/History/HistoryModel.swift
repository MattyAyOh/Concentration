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
   let minutesCompleted:Int
   let secondsCompleted:Int
   let movesMade:Int
   
   init(dateCompleted:Date, timePassed:Int, movesMade:Int) {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd-MMM-yyyy"
      self.dateCompleted = formatter.string(from: dateCompleted)
      
      self.movesMade = movesMade
      self.minutesCompleted = timePassed / 60
      self.secondsCompleted = timePassed % 60
   }
   
   
}
