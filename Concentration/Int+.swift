//
//  Int+.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

extension Int {
   func inMinutes() -> String {
      return String(format: "%02d", self / 60)
   }
   
   func inSeconds() -> String {
      return String(format: "%02d", self % 60)
   }
}
