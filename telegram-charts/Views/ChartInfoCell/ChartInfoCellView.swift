//
//  ChartInfoCellView.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 17/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartInfoCellView: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var countLabel: UILabel!

  private(set) var chart: Chart!
  
  override func prepareForReuse() {
    NotificationCenter.default.removeObserver(self)
  }
  
  func setup(chart: Chart) {
    self.chart = chart
    
    setupContent()
    NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(Keys.themeModeNotification), object: nil)
    updateTheme()
  }
  
  private func setupContent() {
    nameLabel.text = chart.name
    countLabel.text = "\(chart.lines.count) line(s)"
  }
  
  @objc private func updateTheme() {
    backgroundColor = UIColor.additionalCell
    nameLabel.textColor = UIColor.additionalMainText
    countLabel.textColor = UIColor.additionalMainText
  }
}
