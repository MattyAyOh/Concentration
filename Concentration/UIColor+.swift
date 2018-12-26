//
//  UIColor+.swift
//  Concentration
//
//  Created by Matthew Ao on 12/26/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

extension UIColor {
   class func RGBA(r:Int, g:Int, b:Int, a:CGFloat) -> UIColor {
      return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
   }
}
