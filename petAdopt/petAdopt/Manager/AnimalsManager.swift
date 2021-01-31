//
//  animalsManager.swift
//  petAdopt
//  Created by Marangi  on 24/01/2021.


import Foundation
import UIKit
import Alamofire



struct AnimalsMAnager{
  
  
  
  static var accesToken:String = ""
  //accesToken

  let headers: HTTPHeaders = [
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5akNCRzBkZVFndEtPWGRIN1h3M0dUQnZOdVlKa1RsenVySWRXQ0dHTEF6NWZsTG1OWiIsImp0aSI6IjE2ZTE0Njk1MDE1NGMzMDU5MjQ1YTlhNGJiMzE2NDllZjIwNThhNWYyZWIxZjUyMTM4YTVmMmNhNWFhYWI2ZDdhMTg4YTgzN2IzZTY2MDZkIiwiaWF0IjoxNjEyMDk3NjQ3LCJuYmYiOjE2MTIwOTc2NDcsImV4cCI6MTYxMjEwMTI0Nywic3ViIjoiIiwic2NvcGVzIjpbXX0.GG7nPX9gMmUsibSKXpfoX808CCNZ5oFK62sAczcy8wGbYI_bQyzd26pytQxMLbsMRbzqk_9IgR1DJ5R5EVRzUAGe6RH7f9Yo4NLP09tI3JglB8QP2kKG3dS38r51s4-aAyWLoCZHcnYhiB8P8jNSS1NDyLYfU9NxTkS6-T_8_j5SSkt6o-oaIPmIdP_bKyNKwImco-gu7kJnQJbvNh8iR_X1YIUoUBX9wD49nLrHteloblsC21-ZiHCNhpZX10m488mJWUs_wkh6BZuKRzRMjRq4QNiG9M9rVLBLbQ8sF6LOrviCuXNPB1F9lHP7MAOdDr9wAFA5vJHc9vcYsRJcxg"
  ]
  
  let parameters:[String:String] = [
    "grant_type": "client_credentials",
    "client_id" : "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ",
    "client_secret": "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur" ]  // BODY!!!!
  
  
  
  //MARK :-  PASWORD
  
  static func  fetchPassword(success: @escaping(Password)-> ()){
    
    let parameters:[String:String] = [
      "grant_type": "client_credentials",
      "client_id" : "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ",
      "client_secret": "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur" ]  // body
    
    
    
    AF.request(EndPoints.getToken.rawValue, method: .post, parameters: parameters, headers : nil).validate().responseDecodable(of: Password.self)
      { response in
        guard let token:Password = response.value else {
          print ("function decoding error")
          return
        }
      success(token)
      }
  }
  
  
  
  
  
  //MARK :-  OBTAIN TOKEN URL
  
  func fetchToken(){
    
    AF.request(EndPoints.getToken.rawValue, method: .post, parameters: parameters, headers : nil)
      .responseJSON { response in
        if let response =  response.value {
          print(response)
          AnimalsMAnager.accesToken.append("\(response)")
          print ("##############")
          
        }
        
      }
  }
    
    func dogTestingRequest(){
      AF.request("https://api.petfinder.com/v2/animals?type=dog",headers : headers)
        .responseJSON { response in
          print(response.result)
          print("##############")
          //todas las request funcionan, pero falta poder guardar los valores. 
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


