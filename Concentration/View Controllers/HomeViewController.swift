//
//  HomeViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   
   @IBOutlet var loadGameButton: UIButton!
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      loadGameButton.isEnabled = GameManager.modelInCacheAvailable()
   }

   @IBAction func newGamePressed(_ sender: Any) {
      let loadGameSelectVC = {
         let gameSelectVC = GameSelectViewController(nibName: nil, bundle: nil)
         self.present(gameSelectVC, animated: true, completion: nil)
      }
      if GameManager.modelInCacheAvailable() {
         let gameExistsAlert = UIAlertController(title: "Game In Progress", message: "Saved game will be lost. Start a new game?", preferredStyle: UIAlertController.Style.alert)
         
         gameExistsAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            loadGameSelectVC()
         }))
         
         gameExistsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
         }))
         present(gameExistsAlert, animated: true, completion: nil)
      } else {
         loadGameSelectVC()
      }
   }
   
   @IBAction func loadGamePressed(_ sender: Any) {
      let model = GameManager.loadFromCache()
      let gameMainVC = GameMainViewController(model: model)
      self.present(gameMainVC, animated: true, completion: nil)
   }
   
   @IBAction func historyPressed(_ sender: Any) {
      let historyVC = HistoryViewController(nibName: nil, bundle: nil)
      self.present(historyVC, animated: true, completion: nil)
   }
}

