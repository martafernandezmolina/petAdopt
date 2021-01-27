//
//  UIcolor.swift
//  petAdopt
//
//  Created by Marangi  on 24/01/2021.
//

import Foundation
import UIKit


extension UIColor{
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  static func oceansBlue() -> UIColor {
    return  UIColor.rgb(red: 105, green: 178, blue: 176)
    
  }
}
