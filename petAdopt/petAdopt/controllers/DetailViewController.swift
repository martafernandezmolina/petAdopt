//
//  detailViewController.swift
//  petAdopt
//
//  Created by Marangi  on 26/01/2021.
//

import Foundation
import UIKit


class DetailViewController: UIViewController{
  
  //Mark:- OUTLETS
  @IBOutlet weak var petNAme: UILabel!
  @IBOutlet weak var petImage: UIImageView!
  @IBOutlet weak var smallName: UILabel!
  @IBOutlet weak var petType: UILabel!
  @IBOutlet weak var petAge: UILabel!
  @IBOutlet weak var contactPhone: UILabel!
  @IBOutlet weak var contactEmail: UILabel!
  @IBOutlet weak var petAdopt: UIButton!
 
  @IBOutlet weak var petDescribing: UILabel!
  
  //Mark:- Actions
  
  @IBAction func AdoptAction(_ sender: Any) {
  }
  
  let animalInfo = PetsController()
  
  override func viewDidLoad() {
    super .viewDidLoad()
    
    if let selectedPet = PetsViewModel.selectedPet{
      petNAme.text = selectedPet.name
      smallName.text = selectedPet.name
      contactPhone.text = selectedPet.contact.phone
      contactEmail.text = selectedPet.contact.email
      petType.text = selectedPet.type
      petAge.text = selectedPet.age
     
    }
    
    petDescribing.text = PetsViewModel.selectedPet?.description ?? "looking for a family"
 
    
//    petNAme.text = PetsViewModel.selectedPet?.name
//    petImage.image = PrototypeLayout.selectedImage
//    smallName.text = PetsViewModel.selectedPet?.name
//    contactPhone.text = PetsViewModel.selectedPet?.contact.phone ?? "_"
//    contactEmail.text =
//
    
//    self.title =  animalInfo.name
    // FOR IMAGE
//    if let petImage = animalInfo.urlToImage, let myImage = URL(string: segueToimage){
//      segueImageView.af.setImage(withURL: myImage)
//
//  }
  }
  
  
}
