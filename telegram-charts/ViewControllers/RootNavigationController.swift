//
//  RootNavigationController.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return (SettingsManager.shared.themeMode == .day) ? .default : .lightContent
  }
  
  private func setup() {
    interactivePopGestureRecognizer?.isEnabled = false
    navigationBar.isTranslucent = false
    NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(Keys.themeModeNotification), object: nil)
    updateTheme()
  }
  
  @objc private func updateTheme() {
    navigationBar.barTintColor = UIColor.additionalCell
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.additionalMainText]
    setNeedsStatusBarAppearanceUpdate()
  }
  
}
