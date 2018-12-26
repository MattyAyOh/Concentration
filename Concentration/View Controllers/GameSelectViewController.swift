//
//  GameSelectViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet var numPairsLabel: UILabel!
   @IBOutlet var numPairsTextField: UITextField!
   @IBOutlet var easyButton: UIButton!
   @IBOutlet var mediumButton: UIButton!
   @IBOutlet var hardButton: UIButton!
   @IBOutlet var customButton: UIButton!
   @IBOutlet var useImageTileSwitch: UISwitch!
   @IBOutlet var hideCompletedTilesSwitch: UISwitch!
   @IBOutlet var startButton: UIButton!
   
   lazy var allDifficultyButtons = [easyButton, mediumButton, hardButton, customButton]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      numPairsTextField.text = String(K.defaultNumPairs)
      numPairsTextField.delegate = self
      
      startButton.isHidden = true
      numPairsLabel.isHidden = true
      numPairsTextField.isHidden = true
   }
   
   func difficultySelected(_ button:UIButton) {
      for btn in allDifficultyButtons {
         btn?.isSelected = false
      }
      button.isSelected = true

      numPairsLabel.isHidden = (button != customButton)
      numPairsTextField.isHidden = (button != customButton)
      
      startButton.isHidden = false
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   
   @IBAction func backPressed(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
   }
   
   @IBAction func easyPressed(_ sender: Any) {
      numPairsTextField.text = "5"
      difficultySelected(easyButton)
   }
   
   @IBAction func mediumPressed(_ sender: Any) {
      numPairsTextField.text = "10"
      difficultySelected(mediumButton)
   }
   
   @IBAction func hardPressed(_ sender: Any) {
      numPairsTextField.text = "25"
      difficultySelected(hardButton)
   }
   
   @IBAction func customPressed(_ sender: Any) {
      difficultySelected(customButton)
   }
   
   @IBAction func startGamePressed(_ sender: Any) {
      let numPairs = Int(numPairsTextField.text ?? String(K.defaultNumPairs)) ?? K.defaultNumPairs
      let hideCompletedTiles = self.hideCompletedTilesSwitch.isOn
      let useImageTiles = self.useImageTileSwitch.isOn
      let model = GameModel(numPairs: numPairs, hideCompletedTiles:hideCompletedTiles, useImageTiles:useImageTiles)
      let gameMainVC = GameMainViewController(model: model)
      self.present(gameMainVC, animated: true, completion: nil)
   }
   
}
