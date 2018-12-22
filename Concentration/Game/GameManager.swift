//
//  GameManager.swift
//  Concentration
//
//  Created by Matthew Ao on 12/19/18.
//  Copyright © 2018 AYOH. All rights reserved.
//

import Foundation

struct GameManager: DataManager {
   static var cacheURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("cachedGame", isDirectory: false)
      
   static func uploadGameModel(model:GameModel) {
      let urlString = "http://localhost:8000/"
      guard let url = URL(string: urlString) else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
      
      let encoded = try! JSONEncoder().encode(model)
      
      request.httpBody = encoded
      URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
         if let response = response {
            print(response)
         }
         if let data = data {
            do {
               let json = try JSONSerialization.data(withJSONObject: data, options: [])
               print(json)
            }catch {
               print(error)
            }
         }
      })
   }
}
