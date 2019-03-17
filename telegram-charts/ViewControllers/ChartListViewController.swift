//
//  ChartListViewController.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 17/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

class ChartListViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private var charts: [Chart] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupStyle()
    setupContent()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.backgroundColor = UIColor.additionalBackground
    tableView.separatorColor = UIColor.additionalChartLines
  }
  
  private func setupStyle() {
    
  }
  
  private func setupContent() {
    title = NSLocalizedString("Available charts", comment: "")
    charts = DataManager.shared.charts
    tableView.register(UINib(nibName: "ChartInfoCellView", bundle: nil), forCellReuseIdentifier: String(describing: ChartInfoCellView.self))
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
  }
}

extension ChartListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let cell = tableView.cellForRow(at: indexPath) as? ChartInfoCellView,
       let chartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChartsViewController") as? ChartsViewController {
      
      chartViewController.setup(chart: cell.chart)
      navigationController?.pushViewController(chartViewController, animated: true)
    }
  }
}

extension ChartListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return charts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChartInfoCellView.self)) as? ChartInfoCellView else { fatalError() }
    cell.setup(chart: charts[indexPath.row])
    return cell
  }
}
