//
//  AreaSelectorView.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 12/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import UIKit

protocol AreaSelectorViewDelegate: class {
  func didChangeArea(start: Double, finish: Double)
}

class AreaSelectorView: UIView {
  
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var leftGrabberImageView: UIImageView!
  @IBOutlet private weak var rightGrabberImageView: UIImageView!
  
  private weak var delegate: AreaSelectorViewDelegate?
  private var padding: UIEdgeInsets!
  private var rightRecognizer: UIPanGestureRecognizer!
  private var leftRecognizer: UIPanGestureRecognizer!
  
  private var leftGrabberPosition: CGFloat {
    return leftGrabberImageView.frame.minX
  }
  private var rightGrabberPosition: CGFloat {
    return rightGrabberImageView.frame.maxX
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadNib()
  }
  
  private func loadNib() {
    let bundle = Bundle(for: AreaSelectorView.self)
    UINib(nibName: "AreaSelectorView", bundle: bundle).instantiate(withOwner: self, options: nil)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerView)
    containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
  
  func setup(delegate: AreaSelectorViewDelegate?, padding: UIEdgeInsets?) {
    self.delegate = delegate
    self.padding = padding ?? UIEdgeInsets.zero
    setupRecognizers()
    setupStyle()
  }
  
  private func setupRecognizers() {
    let leftRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftGrabberPanned(_:)))
    leftGrabberImageView.addGestureRecognizer(leftRecognizer)
    self.leftRecognizer = leftRecognizer
    let rightRecognizer = UIPanGestureRecognizer(target: self, action: #selector(rightGrabberPanned(_:)))
    rightGrabberImageView.addGestureRecognizer(rightRecognizer)
    self.rightRecognizer = rightRecognizer
  }
  
  private func setupStyle() {
    leftGrabberImageView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    leftGrabberImageView.image = #imageLiteral(resourceName: "icon_arrow_left").withRenderingMode(.alwaysTemplate)
    leftGrabberImageView.tintColor = UIColor.white.withAlphaComponent(0.75)
    rightGrabberImageView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    rightGrabberImageView.image = #imageLiteral(resourceName: "icon_arrow_right").withRenderingMode(.alwaysTemplate)
    rightGrabberImageView.tintColor = UIColor.white.withAlphaComponent(0.75)
  }
  
  private func updateGrapgh() {
    delegate?.didChangeArea(start: Double(leftGrabberPosition / (UIScreen.main.bounds.width - padding.left - padding.right)),
                            finish: Double(rightGrabberPosition / (UIScreen.main.bounds.width - padding.left - padding.right)))
  }
  
  private func checkIfPointIsValid(left: Bool, point: CGPoint) -> Bool {
    if left {
      if point.x < 0.0 {
        // Point is out of the selector's bounds
        return false
      } else if point.x + leftGrabberImageView.frame.width * 2.0 > rightGrabberPosition {
        // Point is over the right grabber
        return false
      }
    } else {
      if point.x + rightGrabberImageView.frame.width > frame.width {
        // Point is out of the selector's bounds
        return false
      } else if point.x < leftGrabberPosition + leftGrabberImageView.frame.width {
        // Point is over the left grabber
        return false
      }
    }
    return true
  }
  
  @objc private func leftGrabberPanned(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: self)
    guard let view = sender.view else { return }
    let newPoint = CGPoint(x: view.frame.origin.x + translation.x, y: view.frame.origin.y)
    if checkIfPointIsValid(left: true, point: newPoint) {
      view.frame.origin = newPoint
      updateGrapgh()
    }
    sender.setTranslation(.zero, in: self)
  }
  
  @objc private func rightGrabberPanned(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: self)
    guard let view = sender.view else { return }
    let newPoint = CGPoint(x: view.frame.origin.x + translation.x, y: view.frame.origin.y)
    if checkIfPointIsValid(left: false, point: newPoint) {
      view.frame.origin = newPoint
      updateGrapgh()
    }
    sender.setTranslation(.zero, in: self)
  }
}
