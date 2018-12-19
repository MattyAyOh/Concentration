//
//  GameSelectViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet var numPairsTextField: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      numPairsTextField.text = String(K.defaultNumPairs)
      numPairsTextField.delegate = self
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
   }
   
   @IBAction func mediumPressed(_ sender: Any) {
      numPairsTextField.text = "10"
      
   }
   
   @IBAction func hardPressed(_ sender: Any) {
      numPairsTextField.text = "25"
   }
   
   @IBAction func startGamePressed(_ sender: Any) {
      let numPairs = Int(numPairsTextField.text ?? String(K.defaultNumPairs)) ?? K.defaultNumPairs
      let model = GameModel(numPairs: numPairs)
      let gameMainVC = GameMainViewController(model: model)
      self.present(gameMainVC, animated: true, completion: nil)
   }
   
}
