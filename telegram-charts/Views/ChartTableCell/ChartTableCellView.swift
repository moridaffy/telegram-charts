//
//  ChartTableCellView.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartTableCellView: UITableViewCell {
  
  @IBOutlet private weak var chartView: UIView!
  @IBOutlet private weak var selectorView: UIView!
  
  private var chart: Chart!
  
  func setup(chart: Chart) {
    self.chart = chart
    
    setupContent()
    NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(Keys.themeModeNotification), object: nil)
    updateTheme()
  }
  
  private func setupContent() {
    selectionStyle = .none
    chartView.backgroundColor = UIColor.clear
    selectorView.backgroundColor = UIColor.clear
  }
  
  @objc private func updateTheme() {
    backgroundColor = UIColor.additionalCell
  }
  
}
