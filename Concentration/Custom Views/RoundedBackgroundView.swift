//
//  RoundedBackgroundView.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class RoundedBackgroundView: UIView {

   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.layer.cornerRadius = 25.0
      self.backgroundColor = UIColor.init(displayP3Red: 0.95, green: 0.95, blue: 0.95, alpha: 0.9)
   }

}
