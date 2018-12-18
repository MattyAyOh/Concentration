//
//  ConcentrationTile.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class ConcentrationTile: UIView {

   var flipped = false
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tileTapped (_:)))
      self.addGestureRecognizer(gesture)
      self.backgroundColor = UIColor.red
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   @objc func tileTapped(_ sender:UITapGestureRecognizer) {
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
         if self.flipped {
            self.transform = CGAffineTransform(scaleX: 1, y: -1)
            self.backgroundColor = UIColor.red
         } else {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.backgroundColor = UIColor.green
         }
         self.flipped = !self.flipped
      }, completion: nil)
   }

}
