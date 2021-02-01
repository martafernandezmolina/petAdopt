//
//  detailViewController.swift
//  petAdopt
//
//  Created by Marangi  on 26/01/2021.
//

import Foundation
import UIKit


class DetailViewController: UIViewController{
  
  //MARK:- OUTLETS
  @IBOutlet weak var petNAme: UILabel!
  @IBOutlet weak var petImage: UIImageView!
  @IBOutlet weak var smallName: UILabel!
  @IBOutlet weak var petType: UILabel!
  @IBOutlet weak var petAge: UILabel!
  @IBOutlet weak var contactPhone: UILabel!
  @IBOutlet weak var contactEmail: UILabel!
  @IBOutlet weak var petAdopt: UIButton!
  
  @IBOutlet weak var petDescribing: UILabel!
  
 
  //MARK:- Actions
  
  @IBAction func AdoptAction(_ sender: Any) {
    if let url = PetsViewModel.selectedPet?.url,  let outsUrl = URL(string: url){
      UIApplication.shared.open(outsUrl)
    }
 
  }
  
  let animalInfo = PetsController()
  
  override func viewDidLoad() {
    super .viewDidLoad()
    layout()
    if let selectedPet = PetsViewModel.selectedPet{
      petNAme.text = selectedPet.name
      smallName.text = selectedPet.name
      contactPhone.text = selectedPet.contact.phone ?? "-"
      contactEmail.text = selectedPet.contact.email
      petType.text = selectedPet.type
      petAge.text = selectedPet.age
      
      for photos in selectedPet.photos {
        if let urlToImage =  photos.large, let myUrl = URL(string: urlToImage){
        petImage.af.setImage(withURL: myUrl)
        }
      }
      
petDescribing.text = PetsViewModel.selectedPet?.description ?? "looking for a family"
      
    }
  }
  func layout(){
    
    petAdopt.layer.cornerRadius = 5
    petImage.layer.borderColor = UIColor.black.cgColor
    
  }
}
