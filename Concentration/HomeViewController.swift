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
      let secondViewController = GameSelectViewController(nibName: nil, bundle: nil)
      self.present(secondViewController, animated: true, completion: nil)
   }
   
   
}

