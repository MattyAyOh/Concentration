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
   
   @IBOutlet var historyTable: UITableView!
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return historyList.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let history = historyList[indexPath.row]
      let header = "Won in \(history.minutesCompleted):\(history.secondsCompleted), with \(history.movesMade) moves"
      let subtitle = "\(history.dateCompleted)"
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: "HistoryCell")
      cell.textLabel?.text = header
      cell.detailTextLabel?.text = subtitle
      cell.selectionStyle = .none
      return cell
   }
   
   override func viewDidLoad() {
      historyList = HistoryManager.loadFromCache() ?? [HistoryModel]()
      historyTable.reloadData()
   }

   @IBAction func backPressed(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
   }
}
