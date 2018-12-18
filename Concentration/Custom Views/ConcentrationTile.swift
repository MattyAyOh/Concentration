//
//  ConcentrationTile.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class ConcentrationTile: UIView {

   let pairNumber: Int
   var flipped = false
   let imageView: UIImageView
   let flippedImage: UIImage?
   let flippedNumberLabel: UILabel
   let unflippedImage = UIImage(imageLiteralResourceName: "Question")
   
   override convenience init(frame: CGRect)
   {
      self.init(frame:frame, pairNumber: 0, image: nil)
   }
   
   init(frame: CGRect, pairNumber: Int, image: UIImage?)
   {
      self.pairNumber = pairNumber
      self.flippedImage = image
      
      let numberLabel = UILabel(frame: frame.insetBy(dx: 5.0, dy: 5.0))
      numberLabel.text = String(pairNumber)
      numberLabel.textAlignment = .center
      numberLabel.adjustsFontSizeToFitWidth = true
      self.flippedNumberLabel = numberLabel
      self.flippedNumberLabel.isHidden = true
      
      self.imageView = UIImageView(frame: frame.insetBy(dx: 3.0, dy: 3.0))
      self.imageView.image = self.unflippedImage
      super.init(frame: frame)
      self.addSubview(self.flippedNumberLabel)
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
            self.flippedNumberLabel.isHidden = true
            self.imageView.isHidden = false
            self.imageView.image = self.unflippedImage
         } else {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.backgroundColor = UIColor.green
            if self.flippedImage != nil {
               self.imageView.image = self.flippedImage
            } else {
               self.imageView.isHidden = true
               self.flippedNumberLabel.isHidden = false
            }
         }
         self.flipped = !self.flipped
      }, completion: nil)
   }

}
