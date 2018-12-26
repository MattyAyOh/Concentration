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
      self.backgroundColor = UIColor.RGBA(r: 242, g: 242, b: 242, a: 0.9)
   }

}
