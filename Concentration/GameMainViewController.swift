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
      NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
   }
   
   @objc func willResignActive(_ notification: Notification) {
      pauseTimer()
   }
   
   @objc func willEnterForeground(_ notification: Notification) {
      resumeTimer()
   }
   
   func resumeTimer() {
      timeAtLoad = CFAbsoluteTimeGetCurrent()
      updateTimerLabel()
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
   }
   
   func pauseTimer() {
      let newSecondsPassed = (backingModel?.secondsPassed ?? 0) + Int(CFAbsoluteTimeGetCurrent() - timeAtLoad)
      backingModel?.secondsPassed = newSecondsPassed
      timer?.invalidate()
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
      
      if backingModel?.completedTilePairs.count == backingModel?.numPairs() {
         let finishedGameAlert = UIAlertController(title: "You Win!", message: "Game will be stored in your History.", preferredStyle: UIAlertController.Style.alert)
         finishedGameAlert.addAction(UIAlertAction(title: "Ok", style: .default))
         
         present(finishedGameAlert, animated: true, completion: {
            ModelManager.emptyCache()
            self.goHome()
         })
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      resumeTimer()
      movesLabel.text = String(backingModel?.movesMade ?? 0)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      pauseTimer()
      
      if let m = backingModel {
         ModelManager.cache(model: m)
      }
   }
   
   @IBAction func pausePressed(_ sender: Any) {
      goHome()
   }
   
   private func goHome() {
      if self.presentingViewController is HomeViewController {
         self.presentingViewController?.dismiss(animated: true, completion: nil)
      } else {
         self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
      }
   }
   
   @IBAction func savePressed(_ sender: Any) {
   }
   
}
