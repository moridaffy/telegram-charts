//
//  CustomError.swift
//  telegram-charts
//
//  Created by Максим Скрябин on 17/03/2019.
//  Copyright © 2019 MSKR. All rights reserved.
//

import Foundation

class CustomError: Error {
  
  let message: String?
  
  init(message: String?) {
    self.message = message
  }
}
