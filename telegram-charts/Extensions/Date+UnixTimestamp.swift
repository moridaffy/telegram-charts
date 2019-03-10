//
//  Date+UnixTimestamp.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import Foundation

extension Date {
  
  init(miliseconds: Int) {
    self = Date(timeIntervalSince1970: TimeInterval(miliseconds) / 1000.0)
  }
  
  var xAxisValue: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter.string(from: self)
  }
}
