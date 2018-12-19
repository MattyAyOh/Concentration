//
//  HistoryViewController.swift
//  Concentration
//
//  Created by Matthew Ao on 12/16/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
   var historyList = [HistoryModel]()
   
   @IBOutlet var totalTimeLabel: UILabel!
   @IBOutlet var totalPairsLabel: UILabel!
   @IBOutlet var averageTimePerPairLabel: UILabel!
   @IBOutlet var averageNumPairsLabel: UILabel!
   @IBOutlet var historyTable: UITableView!
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return historyList.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let history = historyList[indexPath.row]
      let header = "Matched \(history.totalPairs) pairs, in \(history.totalTime.inMinutes()):\(history.totalTime.inSeconds()), with \(history.movesMade) moves"
      let subtitle = "\(history.dateCompleted)"
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: "HistoryCell")
      cell.textLabel?.text = header
      cell.detailTextLabel?.text = subtitle
      cell.selectionStyle = .none
      return cell
   }
   
   override func viewDidLoad() {
      historyList = HistoryManager.loadFromCache() ?? [HistoryModel]()
      
      var totalTime:Int = 0
      var totalPairs:Int = 0
      historyList.forEach {
         totalTime += $0.totalTime
         totalPairs += $0.totalPairs
      }
      let averageNumPairs:Int = historyList.count > 0 ? totalPairs/historyList.count : 0
      let averageTimePerPair:Int = totalTime > 0 ? totalPairs/totalTime : 0
      
      totalTimeLabel.text = "\(totalTime.inMinutes()):\(totalTime.inSeconds())"
      totalPairsLabel.text = String(totalPairs)
      averageNumPairsLabel.text = String(averageNumPairs)
      averageTimePerPairLabel.text = String(averageTimePerPair)
      
      historyTable.reloadData()
   }

   @IBAction func backPressed(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
   }
}
