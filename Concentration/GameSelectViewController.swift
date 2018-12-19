//
//  GameSelectViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   @IBAction func backPressed(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
   }
   
   @IBAction func startGamePressed(_ sender: Any) {
      let model = ConcentrationModel(numPairs: 20, images: [UIImage(imageLiteralResourceName: "Apple")])
      let gameMainVC = GameMainViewController(model: model)
      self.present(gameMainVC, animated: true, completion: nil)
   }

}
