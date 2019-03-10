//
//  ChartsViewController.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 10/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartsViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupStyle()
    setupTableView()
    setupContent()
  }
  
  private func setupStyle() {
    NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(rawValue: Keys.themeModeNotification), object: nil)
    updateTheme()
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: "ChartTableCellView", bundle: nil), forCellReuseIdentifier: String(describing: ChartTableCellView.self))
    tableView.register(UINib(nibName: "ChartLineTableCellView", bundle: nil), forCellReuseIdentifier: String(describing: ChartLineTableCellView.self))
    tableView.register(UINib(nibName: "ThemeModeTableCellView", bundle: nil), forCellReuseIdentifier: String(describing: ThemeModeTableCellView.self))
    tableView.tableFooterView = nil
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func setupContent() {
    title = NSLocalizedString("Statistics", comment: "")
  }
  
  @objc private func updateTheme() {
    tableView.backgroundColor = UIColor.additionalBackground
    tableView.separatorColor = UIColor.additionalChartLines
  }
  
  // TODO: убрать
  var line1 = ChartLine(name: "Joined Channel", colorCode: "4BD964")
  var line2 = ChartLine(name: "Left Channel", colorCode: "FE3C30")
}

extension ChartsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20.0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 && indexPath.row == 0 {
      return 360.0
    } else {
      return 50.0
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      if indexPath.row != 0, let cell = tableView.cellForRow(at: indexPath) as? ChartLineTableCellView {
        cell.enabled = !cell.enabled
      }
    } else {
      SettingsManager.shared.switchThemeMode()
    }
  }
}

extension ChartsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (section == 0) ? 3 : 1
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return (section == 0) ? NSLocalizedString("Followers", comment: "").uppercased() : nil
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      if indexPath.row == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChartTableCellView.self)) as? ChartTableCellView else { fatalError() }
        cell.setup(chart: Chart(lines: [line1, line2]))
        return cell
      } else if indexPath.row == 1 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChartLineTableCellView.self)) as? ChartLineTableCellView else { fatalError() }
        cell.setup(line: line1)
        return cell
      } else if indexPath.row == 2 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChartLineTableCellView.self)) as? ChartLineTableCellView else { fatalError() }
        cell.setup(line: line2)
        return cell
      } else {
        fatalError()
      }
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ThemeModeTableCellView.self)) as? ThemeModeTableCellView else { fatalError() }
      return cell
    }
  }
}
