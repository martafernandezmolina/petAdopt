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
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5akNCRzBkZVFndEtPWGRIN1h3M0dUQnZOdVlKa1RsenVySWRXQ0dHTEF6NWZsTG1OWiIsImp0aSI6ImVkNmFjMTA0ZDRhMTAyY2U1Y2E3MDE1ZWI0Y2E0NGUyM2RkYTcxZjFjZjkyMWJlNTQ4NDQ5ZGI3NjVmYmQzYjNhMWZjYzgwOTQwYTAyYWE4IiwiaWF0IjoxNjExOTU2MTgyLCJuYmYiOjE2MTE5NTYxODIsImV4cCI6MTYxMTk1OTc4Miwic3ViIjoiIiwic2NvcGVzIjpbXX0.uRUHYQSpcjlqrd---iRrsim4aHZ7Oqz1vu9m6-dY9nu3I2UqcWzg3S2mZLrhLfG8kEkMzlRi8QzDtFBGaHRFvRqFSFJZbyXX-vEK_wvqTQCBBoi1KlnvGzvz1A0hy4wsjp78sVfxAvu2L0l0RFePJLHyOv6BAyCpJ3IzQvjUuFC9d0p2kb_ZCocCsurP9sIDeY-1I5W8jdsyYivPQL7_a06zpzqlRDu4mxmOmzhn6mhEVUhaqUEBhl64z8eLsFg_9w4cR8YeBuplk5kW0PEfaL060KZhc8oXwCobA1rzG3_hvPEx4CBLoqEhtaFoW-yiLbm4sI7cLwfvvVROGKT6NQ"
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
  
  
  
  
  
  //MARK :-  TOKEN URL OBTAIN
  
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
  
    
    //MARK :-  DECODING BY TYPE => TO SEARCH
    
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



//  print("error calling GET on /todos/\(id)")
//print(response.result.error!)
