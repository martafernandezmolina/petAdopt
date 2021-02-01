//
//  animalsManager.swift
//  petAdopt
//  Created by Marangi  on 24/01/2021.


import Foundation
import UIKit
import Alamofire



struct AnimalsMAnager{
  
  var readToken = UserDefaults.standard.string(forKey:  UsersDefaultManager.token)
  
  
  let headers: HTTPHeaders = [
    "Authorization": "Bearer  eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5akNCRzBkZVFndEtPWGRIN1h3M0dUQnZOdVlKa1RsenVySWRXQ0dHTEF6NWZsTG1OWiIsImp0aSI6IjE1ZmJjOTY0ZWFkNjY5YmY5NGFkZTY1YmEyOGEzNjJhY2I5YmQwY2ExZjQ3YWEzODk4OTVmN2IwMDVlN2Y5NWVmMGY1NmQxMTkzZGU5YjFkIiwiaWF0IjoxNjEyMTY5NjY5LCJuYmYiOjE2MTIxNjk2NjksImV4cCI6MTYxMjE3MzI2OSwic3ViIjoiIiwic2NvcGVzIjpbXX0.ddrdLwjFucaad2E467sbjfcT7ddjYxIGkiVeqiUPbAxOSuiXHKlSHV1Pg2pYhGeBewNFAUmdKQOyC-b6jnc0tyzlEayLsHP6yEVpG-d-r9vp1gH0S-kl8uPRykGbDjxBOMFU4DpRhNJl3Wo7xN92sMWhBMGHa9MfOHNbAtIvfrqLkAeTxXKYF8NVXQgZSs5T2MK5W2UvWp-jAaKptxBFjToKSeNfwACxPKWOrABa1elyPmtqgATYCmOmaIambzKl0sVSwCcnAfpOS8wRpBTnBENBrZLXUKmI6ie5uC2oQ_htFQpLBE4843mrrlzXb1wzGMu420JzCd5swuxk6SiRsg"
  ]
 
  
  /*
   
   let headers: HTTPHeaders = [
     "Authorization": "Bearer \(UsersDefaultManager.readToken())"
   ]
   
   */
  
  
  let parameters:[String:String] = [
    "grant_type": "client_credentials",
    "client_id" : "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ",
    "client_secret": "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur" ]  // BODY!!!!
  
 
  
  //MARK :-  PASWORD
  
//  static func fetchPassword(){
//
//
//    let parameters:[String:String] = [
//      "grant_type": "client_credentials",
//      "client_id" : "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ",
//      "client_secret": "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur" ]  // body
//
//    AF.request(EndPoints.getToken.rawValue, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//        if let data = response.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
//            as? [String: Any])?["access_token"] as? String {
//          UsersDefaultManager.setToken(token: token)
//            print("\nRefresh token completed successfully. New token is: \(token)\n")
//
//        }
//    }
//
//  }
  
  
  //MARK :-  OBTAIN TOKEN URL
  
  func fetchToken(){
    
    AF.request(EndPoints.getToken.rawValue, method: .post, parameters: parameters, headers : nil)
      .responseJSON { response in
        if let response =  response.value {
          print(response)
         // AnimalsMAnager.accesToken.append("\(response)")
          print ("##############")
          
        }
        
      }
  }
    
    func dogTestingRequest(){
      AF.request("https://api.petfinder.com/v2/animals?type=dog",headers : headers)
        .responseJSON { response in
          print(response.result)
          print("##############")
          
        }
    }
    
    
    // MARK :- DECODING ALL ANIMALS
    
  func generalAnimals(success: @escaping(AnimalList)-> ()) {

      AF.request(EndPoints.generalAnimals.rawValue, parameters: nil, headers: headers).validate().responseDecodable(of: AnimalList.self){
        response in
  
        guard let animalList:AnimalList  = response.value else {
          debugPrint("Error while calling \(#function)")
          debugPrint(response.description)
          return}
        success(animalList)
      }
    }
  
    
    //MARK :- DECODING BY TYPE => TO SEARCH
    
    func searchAnimals(type:String,
                       success: @escaping(AnimalList)-> ()) {
      
      let parameters:[String:String]  = [EndpointsParameters.type.rawValue: type]
      
      AF.request(EndPoints.generalAnimals.rawValue, parameters: parameters, headers : headers).validate().responseDecodable(of:AnimalList.self){
        response in
        
        guard let animalsPerType: AnimalList = response.value else {
          return
        }
        success(animalsPerType)
      }
    }
  }


