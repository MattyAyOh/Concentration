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

   var model:ConcentrationModel?
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
      mainGrid.delegate = self
   }
   
   @objc func updateTimerLabel() {
      let timeElapsed = (model?.secondsPassed ?? 0) + Int(CFAbsoluteTimeGetCurrent() - timeAtLoad)
      let minutesElapsed = String(format: "%02d", timeElapsed / 60)
      let secondsElapsed = String(format: "%02d", timeElapsed % 60)
      timerLabel.text = "\(minutesElapsed):\(secondsElapsed)"
   }
   
   func pairGuessed() {
      model?.movesMade += 1
      movesLabel.text = String(model?.movesMade ?? 0)
   }
   
   func pairFound(_ pairNum: Int) {
      model?.completedTilePairs.insert(pairNum)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      timeAtLoad = CFAbsoluteTimeGetCurrent()
      updateTimerLabel()
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
      movesLabel.text = String(model?.movesMade ?? 0)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      model?.secondsPassed = (model?.secondsPassed ?? 0) + Int(CFAbsoluteTimeGetCurrent() - timeAtLoad)
      timer?.invalidate()
   }
   
   
   
   @IBAction func pausePressed(_ sender: Any) {
   }
   @IBAction func savePressed(_ sender: Any) {
   }
   
}
