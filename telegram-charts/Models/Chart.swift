//
//  Chart.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 16/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class Chart {
  
  let lines: [ChartLine]
  let name: String
  
  init(data: Any, index: Int) throws {
    guard let chartData = data as? [String: Any] else { throw CustomError(message: NSLocalizedString("No chart data found", comment: "")) }
    guard let columnsData = chartData["columns"] as? [Any] else { throw CustomError(message: NSLocalizedString("No \"columns\" value found", comment: ""))}
    guard let colorsData = chartData["colors"] as? [String: String] else { throw CustomError(message: NSLocalizedString("No \"colors\" value found", comment: ""))}
    guard columnsData.count == (colorsData.count + 1) else { throw CustomError(message: NSLocalizedString("Invalid objects count", comment: ""))}
    var newLines: [ChartLine] = []
    
    for i in 0...columnsData.count - 1 {
      if let columnData = columnsData[i] as? [Any],
         let columnName = columnData.first as? String {
       
        var columnValues: [Int] = []
        for j in 1...columnData.count - 1 {
          if let value = columnData[j] as? Int {
            columnValues.append(value)
          }
        }
        
        var lineColor: UIColor {
          if let colorCode = colorsData[columnName] {
            return UIColor(hex: colorCode)
          } else {
            return UIColor.red
          }
        }
        
        
        newLines.append(ChartLine(name: columnName,
                                  values: columnValues,
                                  typeValue: (columnName == "x") ? "x" : "line",
                                  color: lineColor))
      }
    }
    
    self.name = NSLocalizedString("Chart", comment: "") + " #\(index + 1)"
    self.lines = newLines
  }
  
}
