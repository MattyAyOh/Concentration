//
//  HomeViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }

   @IBAction func newGamePressed(_ sender: Any) {
      let gameSelectVC = GameSelectViewController(nibName: nil, bundle: nil)
      self.present(gameSelectVC, animated: true, completion: nil)
   }
   
   @IBAction func loadGamePressed(_ sender: Any) {
   }
   
   @IBAction func historyPressed(_ sender: Any) {
      let historyVC = HistoryViewController(nibName: nil, bundle: nil)
      self.present(historyVC, animated: true, completion: nil)
   }
}

