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
   let imageView: UIImageView
   let unflippedImage = UIImage(imageLiteralResourceName: "Question")
   
   override init(frame: CGRect) {
      self.imageView = UIImageView(frame: frame.insetBy(dx: 3.0, dy: 3.0))
      self.imageView.image = self.unflippedImage
      super.init(frame: frame)
      self.addSubview(self.imageView)
      let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tileTapped (_:)))
      self.addGestureRecognizer(gesture)
      self.backgroundColor = UIColor.darkGray
      self.bounds = self.frame.insetBy(dx: 1.0, dy: 1.0)
      self.layer.cornerRadius = 5.0
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
