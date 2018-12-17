//
//  HomeViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

   @IBOutlet var titleRoundedBackgroundView: UIView!
   @IBOutlet var buttonRoundedBackgroundView: UIView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      buttonRoundedBackgroundView.layer.cornerRadius = 25.0
      buttonRoundedBackgroundView.backgroundColor = UIColor.init(displayP3Red: 0.95, green: 0.95, blue: 0.95, alpha: 0.9)
   }

   
}

