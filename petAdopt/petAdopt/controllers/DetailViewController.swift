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
  
  
  //Mark:- Actions
  
  @IBAction func AdoptAction(_ sender: Any) {
  }
  
  
  override func viewDidLoad() {
    super .viewDidLoad()
    
    petNAme.text = PrototypeLayout.selectedName
    petImage.image = PrototypeLayout.selectedImage
    smallName.text = PrototypeLayout.selectedName
    
//    guard let animalInfo:Animals = PetsViewModel.selectedPet else {return}
//    self.title =  animalInfo.name
    // FOR IMAGE
//    if let petImage = animalInfo.urlToImage, let myImage = URL(string: segueToimage){
//      segueImageView.af.setImage(withURL: myImage)
//
//  }
  }
  
  
}
