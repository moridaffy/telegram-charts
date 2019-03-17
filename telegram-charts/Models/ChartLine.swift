//
//  ChartLine.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 16/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartLine {
  
  let name: String
  let values: [Int]
  let type: LineType
  let color: UIColor
  
  init(name: String, values: [Int], typeValue: String, color: UIColor) {
    self.name = name
    self.values = values
    self.type = LineType(rawValue: typeValue) ?? .unknown
    self.color = color
  }
}

extension ChartLine {
  enum LineType: String {
    case unknown
    case line
    case x
  }
}
