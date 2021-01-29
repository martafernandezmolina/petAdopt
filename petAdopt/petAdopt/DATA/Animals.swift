//
//  Animals.swift
//  petAdopt
//
//  Created by Marangi  on 29/01/2021.
//

import Foundation



import Foundation
// MARK: - Animal
struct Animals: Codable {
  let id: Int
  let organization_id: String
  let url: String
  let type, species: String
  let age:String
  let gender:String
  let size: String
  let coat: String?
  let name:String
  let description: String?
  let photos: [Photos]
  let contact: Contact
  
  
}

