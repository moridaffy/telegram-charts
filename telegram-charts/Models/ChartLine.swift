//
//  ChartLine.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartLine {
  
  let name: String
  let color: UIColor
  
  init(name: String, colorCode: String) {
    self.name = name
    self.color = UIColor(hex: colorCode)
  }
  
}
