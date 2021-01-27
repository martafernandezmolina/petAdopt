//
//  AdoptMAnager.swift
//  petAdopt
//
//  Created by Marangi  on 24/01/2021.
//

import Foundation
import Alamofire
import UIKit

var token_url = "https://api.petfinder.com/v2/oauth2/token"

let client_id = "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ"
let client_secret = "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur"
let token_body = "grant_type=client_credentials&client_id=\(client_id)&client_secret=\(client_secret)"

class AdoptManager {
  
  
  
  
  
  static func fetchAnimals(success: @escaping("AnimalLiist")-> ()){
    
    AF.request(endPoints.headline.url).validate().responseDecodable(of:"AnimalLiist".self){(response) in
      guard let animalList:AnimalLiist = response.value else {
        print(response.error as Any)
        print("not working 😭")
        return
        
      }
      print("he pasado fetchAnimals")
      success(animalList)
    }
    
    func fetchPets(type:String,
                   success: @escaping(AnimalLiist)-> ()){
      
      let fullUrl = "\(endPoints.headline.url)/\(type)"
      
    }
    
    
    
    // Prepare URL
    let token_url = "<https://api.petfinder.com/v2/oauth2/token>"
    let url = URL(string: token_url)
    guard let requestUrl = url else {
      print ("## not found url")
      fatalError() }
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
    
    // HTTP Request Parameters which will be sent in HTTP Request Body
    let postString = token_body
    // Set HTTP Request Body
    request.httpBody = postString.data(using: String.Encoding.utf8);
    // Perform HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
      // Check for Error
      if let error = error {
        print("Error took place \(error)")
        return
      }
      
      // Convert HTTP Response Data to a String
      if let data = data, let dataString = String(data: data, encoding: .utf8) {
        print("Response data string:\n \(dataString)")
      }
    }
    task.resume()
    
  }
}
