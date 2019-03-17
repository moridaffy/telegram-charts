//
//  DataManager.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 12/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import Foundation

class DataManager {
  
  static let shared = DataManager()
  
  private var charts: [Chart] = []
  
  func setup() {
    guard let fileUrl = Bundle.main.url(forResource: "chart_data", withExtension: "json") else { fatalError("Chart file not found") }
    do {
      let data = try Data(contentsOf: fileUrl)
      let jsonObject = try JSONSerialization.jsonObject(with: data) as? [Any]
      var charts: [Chart] = []
      for chartData in jsonObject ?? [] {
        if let chart = try? Chart(data: chartData) {
          charts.append(chart)
        }
      }
      self.charts = charts
    } catch let error {
      fatalError(error.localizedDescription)
    }
  }
  
}
