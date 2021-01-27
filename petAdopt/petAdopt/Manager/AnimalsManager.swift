//
//  animalsManager.swift
//  petAdopt
//  Created by Marangi  on 24/01/2021.


import Foundation
import UIKit
import Alamofire



struct AnimalsMAnager{
  
  
 
  
  static let accesToken:String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5akNCRzBkZVFndEtPWGRIN1h3M0dUQnZOdVlKa1RsenVySWRXQ0dHTEF6NWZsTG1OWiIsImp0aSI6ImJiZWYyNzYyODI0ZjMyNWZlOTJhODgyZjkzNjNiNjMzNTJhMThiNzhmNTlhOGM2MmJjODY4N2ZmNTllMDdiYTk0NmNhMWVhMDUzYzJjYjBlIiwiaWF0IjoxNjExNjk4OTAyLCJuYmYiOjE2MTE2OTg5MDIsImV4cCI6MTYxMTcwMjUwMiwic3ViIjoiIiwic2NvcGVzIjpbXX0.zlqZ9uE5Ep0BLiqhC59TFv63tzJ7aZTmSycBbjMfs5NTNN9GieBM_WnchAx8a5pXnAvse4JFtxvDCG_cz-J2_w0TCujK8vyjCYhLI7UKGsEGrMir04mc0ECc-FVtVOo2wsN2ILJ3gEmTKDvGuK5Y53XUzPOh5ktMYTrGV0DoVOSQL7lI038v3g6Se6VmWp0z4d-vqiQStNfxHpsLCigFfnyf3dj3GepgKgXBsZnCRy-o6PX8t3RusDFM8HDUJsp3dpv4HvqvWP7AezrO1EOIa7Pnb20Jc546k_kNGH2GeVh2k7sUC1fLYdNRksfQs2KkFlF8qmdDICb4jGONvPdBUA"
  
  
  let headers: HTTPHeaders = [
    "Authorization": "Bearer \(accesToken)"
  ]
  
  let parameters:[String:String] = [
    "grant_type": "client_credentials",
    "client_id" : "9jCBG0deQgtKOXdH7Xw3GTBvNuYJkTlzurIdWCGGLAz5flLmNZ",
    "client_secret": "RUpohoORBvS9yjJzM6UaXgP5T4bBZBWqnI9ZZXur" ]  // BODY!!!!
  
  
  
  //MARK :-  TOKEN URL OBTAIN
  
  func obtainToken(){
    
    AF.request(EndPoints.getToken.rawValue, method: .post, parameters: parameters, headers : nil)
      .responseJSON { response in
        
        print(response.value)
        //saveToken.append(contentsOf: response)
        print ("############## 🔥😝😛🤩")
        
      }
    
  }
  
  
  
  
  
  func dogTestingRequest(){
    AF.request("https://api.petfinder.com/v2/animals?type=dog",headers : headers)
      .responseJSON { response in
        print(response)
        print(response.result)
        print("##############")
        
      }
  }
  
  
  // MARK :- DECODING ALL ANIMALS
  
  func generalAnimals(success: @escaping(AnimalList)-> ()) {
    
    AF.request(EndPoints.generalAnimals.rawValue, parameters: nil, headers: headers).validate().responseDecodable(of: AnimalList.self){
      response in
      guard let animalList:AnimalList  = response.value else {
        debugPrint(response.description)
        return}
      
      success(animalList)
    }
    
  }
  
  
  //MARK :-  DECODING BY TYPE => TO SEARCH
  
  func searchAnimals(type:String,
                     success: @escaping(AnimalList)-> ()) {
    
    // let parameters:[String:String]  = [EndpointsParameters.type.rawValue: type]
    
    AF.request(EndPoints.generalAnimals.rawValue, parameters: parameters, headers : headers).validate().responseDecodable(of:AnimalList.self){
      response in
      
      guard let animals: AnimalList = response.value else {
        return
      }
      
      success(animals)
    }
    
    
    
    
  }
  
}
