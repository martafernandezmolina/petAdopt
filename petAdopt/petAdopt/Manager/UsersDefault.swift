//
//  UsersDefault.swift
//  petAdopt
//
//  Created by Marangi  on 01/02/2021.
//

import Foundation

class UsersDefaultManager {
  
  
  static var token:String = "Token"
  
  static func setToken(token: String) {
    UserDefaults.standard.set(token, forKey: UsersDefaultManager.token)
      UserDefaults.standard.synchronize()
    
  }
  static func readToken(){
    UserDefaults.standard.string(forKey: UsersDefaultManager.token)
  }
 
  
}
