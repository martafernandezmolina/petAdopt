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
    "Authorization": "Bearer  eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5akNCRzBkZVFndEtPWGRIN1h3M0dUQnZOdVlKa1RsenVySWRXQ0dHTEF6NWZsTG1OWiIsImp0aSI6IjdkMmIxNzM2ZWFkNDhhZjY4MGM3NzUyNjFkMDQ0NWU2YjU2Nzk2MGZjOWNkZjAxNzhjYjRhNjQwNGRmNDkzMGVmZDI5NDkwOGRjNzdlNjU2IiwiaWF0IjoxNjEyMTc0NTMxLCJuYmYiOjE2MTIxNzQ1MzEsImV4cCI6MTYxMjE3ODEzMSwic3ViIjoiIiwic2NvcGVzIjpbXX0.tltt-1uvFJH6-BENZtmib487UAAmpXB-vIfVzVZRezQGwd2BG83pesQGaPRH2iC_nuAVJwe9WpR1OM8zY2dJp1pNzoTHMMTBPtnRKJJVGELS5t6hWlcxPwbk5Hh3O7-BNk3bK0idQBcZDLCpzMSmPXHIw3R-cAbDOtGjzXw6KhL-zZlz7qO5jjv9GNuKF3pfBnr6ju_9CVn1ASOsijyURanT2pgq9AlA-t8TIulEQ_v8j4_PnYAhVZkfVKHV1IBUGc3Hj8UkuuzR3wl4pBbFfqXsvxWsncQ2V6v1FdqC6fIDNzI4ROBAY_HavXvOi02XVDOG9bi2sXEVk0U_T79xEw"
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
  
  static func fetchPassword(){


    let parameters:[String:String] = [
      "grant_type": "client_credentials",
      "client_id" : "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ",
      "client_secret": "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur" ]  // body

    AF.request(EndPoints.getToken.rawValue, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
        if let data = response.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
            as? [String: Any])?["access_token"] as? String {
          UsersDefaultManager.setToken(token: token)
            print("\nRefresh token completed successfully. New token is: \(token)\n")

        }
    }

  }
  
  
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


