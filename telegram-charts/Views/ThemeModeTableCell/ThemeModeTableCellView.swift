//
//  ThemeModeTableCellView.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ThemeModeTableCellView: UITableViewCell {
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  private func setup() {
    selectionStyle = .none
    NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(rawValue: Keys.themeModeNotification), object: nil)
    updateTheme()
  }
  
  @objc private func updateTheme() {
    titleLabel.text = SettingsManager.shared.themeMode.switchText
    titleLabel.textColor = UIColor.additionalTint
    backgroundColor = UIColor.additionalCell
  }
  
}
