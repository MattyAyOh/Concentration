//
//  ConcentrationTile.swift
//  Concentration
//
//  Created by Matthew Ao on 12/17/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

protocol TileDelegate: NSObjectProtocol {
   func tileFlipped(_ tile:ConcentrationTile)
   func resetGuessedTiles()
}

class ConcentrationTile: UIView {
   weak var delegate: TileDelegate?
   private var flippedImage: UIImage?
   private(set) var pairNumber: Int
   private var flipped = false
   let imageView: UIImageView
   let flippedNumberLabel: UILabel
   let unflippedImage = UIImage(imageLiteralResourceName: "Question")
   
   var isAnimating:Bool = false
   var isShowingWrongGuess:Bool = false
   
   override convenience init(frame: CGRect) {
      self.init(frame:frame, pairNumber: 0, image: nil)
   }
   
   convenience init(frame:CGRect, delegate:TileDelegate?) {
      self.init(frame:frame, pairNumber: 0, image: nil)
      self.delegate = delegate
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
      self.imageView.setImageColor(color: UIColor.white)
      super.init(frame: frame)
      self.addSubview(self.flippedNumberLabel)
      self.addSubview(self.imageView)
      let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tileTapped (_:)))
      self.addGestureRecognizer(gesture)
      self.bounds = self.frame.insetBy(dx: 1.0, dy: 1.0)
      self.layer.cornerRadius = 5.0
      self.backgroundColor = K.unflippedColor
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func updateTile(withNewNum newNum:Int, andNewImage newImage:UIImage?) {
      self.flippedImage = newImage
      self.pairNumber = newNum
      self.flippedNumberLabel.text = String(newNum)
   }
   
   //MARK: - Flipping
   func wrongGuessKeepFlipped() {
      self.isShowingWrongGuess = true
      self.backgroundColor = K.wrongGuessColor
      DispatchQueue.main.asyncAfter(deadline: .now()+1) {
         if self.isShowingWrongGuess {
            self.unflipTile()
         }
      }
   }
   
   @objc func tileTapped(_ sender:UITapGestureRecognizer) {
      delegate?.resetGuessedTiles()
      if !self.flipped && !self.isAnimating {
         isAnimating = true
         UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.flipTileAndNotify()
            self.isAnimating = false
         }, completion: nil)
      }
   }
   
   func flipTile() {
      self.transform = CGAffineTransform(scaleX: 1, y: -1)
      self.transform = CGAffineTransform(scaleX: 1, y: 1)
      self.backgroundColor = UIColor.white
      if self.flippedImage != nil {
         self.imageView.image = self.flippedImage
      } else {
         self.imageView.isHidden = true
         self.flippedNumberLabel.isHidden = false
      }
      self.flipped = true
   }

   func flipTileAndNotify() {
      flipTile()
      self.delegate?.tileFlipped(self)
   }
   
   func unflipTile() {
      self.transform = CGAffineTransform(scaleX: 1, y: -1)
      self.transform = CGAffineTransform(scaleX: 1, y: 1)
      self.backgroundColor = K.unflippedColor
      self.flippedNumberLabel.isHidden = true
      self.imageView.isHidden = false
      self.imageView.image = self.unflippedImage
      self.imageView.setImageColor(color: UIColor.white)
      self.flipped = false
      self.isShowingWrongGuess = false
   }
}
