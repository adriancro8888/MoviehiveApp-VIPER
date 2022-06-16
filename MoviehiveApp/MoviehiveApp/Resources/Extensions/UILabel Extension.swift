//
//  UILabel Formatter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
import UIKit

extension UILabel{
    func changeDateFormat(str: String) {
        let date = str.components(separatedBy: "-")
        self.text = "\(date[2]).\(date[1]).\(date[0])"
    }
}
