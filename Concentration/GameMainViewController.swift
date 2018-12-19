//
//  GameMainViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class GameMainViewController: UIViewController, GridViewDelegate {
   @IBOutlet var movesLabel: UILabel!
   @IBOutlet var timerLabel: UILabel!
   var timer: Timer?
   var timeAtLoad = CFAbsoluteTimeGetCurrent()
   let formatter: DateFormatter = {
      let tmpFormatter = DateFormatter()
      tmpFormatter.dateFormat = "mm:ss"
      return tmpFormatter
   }()

   var backingModel:ConcentrationModel?
   init(model: ConcentrationModel?) {
      self.backingModel = model
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
      
      guard let m = self.backingModel else {return}
      mainGrid.loadFromModel(m)
      mainGrid.delegate = self
   }
   
   @objc func updateTimerLabel() {
      let timeElapsed = (backingModel?.secondsPassed ?? 0) + Int(CFAbsoluteTimeGetCurrent() - timeAtLoad)
      let minutesElapsed = String(format: "%02d", timeElapsed / 60)
      let secondsElapsed = String(format: "%02d", timeElapsed % 60)
      timerLabel.text = "\(minutesElapsed):\(secondsElapsed)"
   }
   
   func pairGuessed() {
      backingModel?.movesMade += 1
      movesLabel.text = String(backingModel?.movesMade ?? 0)
   }
   
   func pairFound(_ pairNum: Int) {
      backingModel?.completedTilePairs.insert(pairNum)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      timeAtLoad = CFAbsoluteTimeGetCurrent()
      updateTimerLabel()
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
      movesLabel.text = String(backingModel?.movesMade ?? 0)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      let newSecondsPassed = (backingModel?.secondsPassed ?? 0) + Int(CFAbsoluteTimeGetCurrent() - timeAtLoad)
      backingModel?.secondsPassed = newSecondsPassed
      timer?.invalidate()
      
      if let m = backingModel {
         ModelManager.cache(model: m)
      }
   }
   
   @IBAction func pausePressed(_ sender: Any) {
      if self.presentingViewController is HomeViewController {
         self.presentingViewController?.dismiss(animated: true, completion: nil)
      } else {
         self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
      }
   }
   
   @IBAction func savePressed(_ sender: Any) {
   }
   
}
