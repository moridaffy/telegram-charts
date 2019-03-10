//
//  UIColor+CustomColors.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

extension UIColor {
  static var additionalMainText: UIColor {
    switch SettingsManager.shared.themeMode {
    case .day:
      return UIColor.black
    case .night:
      return UIColor.white
    }
  }
  
  static var additionalChartLines: UIColor {
    switch SettingsManager.shared.themeMode {
    case .day:
      return UIColor(hex: "CFD1D2")
    case .night:
      return UIColor(hex: "10171E")
    }
  }
  
  static var additionalChartText: UIColor {
    switch SettingsManager.shared.themeMode {
    case .day:
      return UIColor(hex: "989EA3")
    case .night:
      return UIColor(hex: "607081")
    }
  }
  
  static var additionalCell: UIColor {
    switch SettingsManager.shared.themeMode {
    case .day:
      return UIColor(hex: "FEFEFE")
    case .night:
      return UIColor(hex: "212F3F")
    }
  }
  
  static var additionalBackground: UIColor {
    switch SettingsManager.shared.themeMode {
    case .day:
      return UIColor(hex: "EFEFF4")
    case .night:
      return UIColor(hex: "18212D")
    }
  }
  
  static var additionalHandle: UIColor {
    return UIColor(hex: "CAD4DE")
  }
  
  static var additionalTint: UIColor {
    return UIColor(hex: "1791FF")
  }
  
  convenience init(hex: String) {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }
    
    if cString.count != 6 {
      self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    } else {
      var rgbValue: UInt32 = 0
      Scanner(string: cString).scanHexInt32(&rgbValue)
      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: 1.0)
    }
  }
}
