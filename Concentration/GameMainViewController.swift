//
//  GameMainViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class GameMainViewController: UIViewController {

   let model:ConcentrationModel?
   init(model: ConcentrationModel?) {
      self.model = model
      super.init(nibName: nil, bundle: nil)
   }
   
   override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      fatalError("Need to call init w/ Concentration Model")
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   @IBOutlet var mainGrid: ConcentrationGridView!
   override func viewDidLoad() {
      super.viewDidLoad()
      
      guard let m = self.model else {return}
      mainGrid.loadFromModel(m)
    }
}
