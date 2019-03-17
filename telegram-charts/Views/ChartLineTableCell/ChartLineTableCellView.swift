//
//  ChartLineTableCellView.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartLineTableCellView: UITableViewCell {
  
  @IBOutlet private weak var colorView: UIView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var checkImageView: UIImageView!
  
  override func prepareForReuse() {
    NotificationCenter.default.removeObserver(self)
  }
  
  private(set) var line: ChartLine!
  var enabled: Bool! {
    didSet {
      checkImageView.isHidden = !enabled
    }
  }
  
  func setup(line: ChartLine) {
    self.line = line
    
    setupContent()
    NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(Keys.themeModeNotification), object: nil)
    updateTheme()
  }
  
  private func setupContent() {
    selectionStyle = .none
    colorView.backgroundColor = line.color
    colorView.layer.cornerRadius = 2.0
    colorView.layer.masksToBounds = true
    titleLabel.text = line.name
    checkImageView.image = #imageLiteral(resourceName: "icon_check").withRenderingMode(.alwaysTemplate)
    checkImageView.tintColor = UIColor.additionalTint
    enabled = false
  }
  
  @objc private func updateTheme() {
    backgroundColor = UIColor.additionalCell
    titleLabel.textColor = UIColor.additionalMainText
  }
  
}
