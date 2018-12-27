//
//  UIImageView+.swift
//  Concentration
//
//  Created by Matthew Ao on 12/27/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

extension UIImageView {
   func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
   }
}
