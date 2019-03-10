//
//  SettingsManager.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import Foundation

struct Keys {
  static let themeModeValue: String = "ru.mskr.telegram-charts.themeModeValue"
  static let themeModeNotification: String = "ru.mskr.telegram-charts.themeModeNotification"
}

class SettingsManager {
  
  static let shared = SettingsManager()
  
  var themeMode: ThemeMode {
    get {
      return ThemeMode(rawValue: UserDefaults.standard.value(forKey: Keys.themeModeValue) as? Int ?? 0) ?? .day
    }
  }
  
  func switchThemeMode() {
    UserDefaults.standard.set(themeMode.anotherMode.rawValue, forKey: Keys.themeModeValue)
    NotificationCenter.default.post(Notification(name: Notification.Name(Keys.themeModeNotification)))
  }
}

extension SettingsManager {
  enum ThemeMode: Int {
    case day
    case night
    
    var switchText: String {
      switch self {
      case .day:
        return NSLocalizedString("Switch to Night Mode", comment: "")
      case .night:
        return NSLocalizedString("Switch to Day Mode", comment: "")
      }
    }
    
    var anotherMode: ThemeMode {
      return (self == .day) ? .night : .day
    }
  }
}
