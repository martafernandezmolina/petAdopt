//
//  endPoints.swift
//  petAdopt
//
//  Created by Marangi  on 24/01/2021.
//

import Foundation
import UIKit
import Alamofire

enum EndPoints:String {
  case getToken = "https://api.petfinder.com/v2/oauth2/token"   //POST
  case generalAnimals = "https://api.petfinder.com/v2/animals" // GET
  case animalsPerType = "https://api.petfinder.com/v2/types"  // GET
  
  

   var url: String {self.rawValue }
}

enum EndpointsParameters:String {
  case type,name
  
}


