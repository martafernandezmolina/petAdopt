//
//  ViewController.swift
//  petAdopt
//
//  Created by Marangi  on 24/01/2021.
//

import Foundation
import UIKit
import AlamofireImage



let myReuseIdentifier = String(describing:PetCell.self)

class PetsController: UIViewController {
  
  let animalsManager = AnimalsMAnager()
  
  var animaPerType:[Animals]?
  var generalAnimalList:[Animals]?
  
  
  
  // MARK: - OUTLETS ‼️
  
  @IBOutlet weak var textFieldOutlet: UITextField!
  @IBOutlet var tableview:UITableView!
  
  
  override func viewDidLoad() {
    
    
    
    tableview.delegate = self
    tableview.dataSource = self
    let nib = UINib (nibName: "PetCell", bundle: nil)
    tableview.register(nib, forCellReuseIdentifier: "PetCell")
    gettingPassword()
    //allAnimals()
    animalsManager.fetchToken()
    fetchAnimals()
    
    self.title = "PET ADOPT 🐕"
    
    
  }
  
  
  // MARK: - NEEDED FETCHES
  
  /*func allAnimals(){
   
   animalsManager.generalAnimals(success:{(animalsInfo) in
   self.animalList? = animalsInfo.animals
   self.tableview.reloadData()
   print(animalsInfo.animals)})
   }
   
   */
  
  //  func fetchEverything(_ type:String){
  //     animalsManager.searchType(type: type,
  //                                success:{(infoType) in
  //                                  self.animals = infoType.animal
  //
  //                                  self.tableview.reloadData()
  //                                  print("in succes block \n\n")})
  //
  //  }
  
}

// Mark: - DATASOURCE ‼️

extension PetsController: UITableViewDataSource{
  
//    func numberOfSections(in tableView: UITableView) -> Int {
//     PrototypeLayout.imagesLoop.count
//    }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return  arrayOfImages(PrototypeLayout.imagesLoop).count
    //return generalAnimalList?.count ?? 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: myReuseIdentifier, for: indexPath) as! PetCell
    
    
    if let animalsInformation = generalAnimalList?[indexPath.row]{
      cell.labelCell.textColor = .oceansBlue()
      cell.labelCell.text = animalsInformation.name
      cell.descriptionPet.text = animalsInformation.gender
      
      
    
      
    }
    
    cell.imageCell.image = arrayOfImages(PrototypeLayout.imagesLoop)[indexPath.row]
    
    //cell.descriptionPet.text = generalAnimalList?[indexPath.row].gender
    
     
    
    // IMG
    
//    if let urlToImage = generalAnimalList?[indexPath.row].photos.small,  let urlImage = URL(string: urlToImage){
//
//       cell.imageCell.af.setImage(withURL: urlImage)
//}

  
    
    
   /*
        cell.imageCell.image = arrayOfImages(PrototypeLayout.imagesLoop)[indexPath.row]
        cell.labelCell.text = PrototypeLayout.imagesLoop[indexPath.row]
        cell.labelCell.textColor = .oceansBlue()
    
    
    */
    
    
    
    //    if let animals = animalList?[indexPath.row]{
    //      cell.labelCell.text = animals.name
    //
    //      let urlToImage = animals.photos.small
    //      if let urlImage = URL(string: urlToImage){
    //            cell.imageCell.af.setImage(withURL: urlImage)
    //          }
    //                                 Aquí cuando decodifique  correctamente
    //    }
    
    return cell
  }
  
  
  //   func fetchAnimalType(_ type:String){
  //      animalsManager.searchType(type: type,
  //                                  success:{(nformation) in
  //                                    self.animaPerType = information
  //                                    self.tableview.reloadData()
  //
  //    }
  
  
  func arrayOfImages(_ image:[String]) -> [UIImage]{
    var imageArray = [UIImage]()
    image.forEach { img in
      if let image = UIImage(named: img){
        imageArray.append(image)
      }
    }
    return imageArray
  }
  
  func fetchAnimals(){
    
    animalsManager.generalAnimals(success:{(animalListt) in
      self.generalAnimalList = animalListt.animals
      self.tableview.reloadData()
      print(animalListt.animals)
      print ("LOL JAJ")
    })
  }
  
}

func gettingPassword(){
  AnimalsMAnager.fetchPassword { (Password) in
    
    PetsViewModel.myPAss = Password.access_token
    print(type(of:  PetsViewModel.myPAss))
  }
}

// Mark: - DELEGATE ‼️
extension PetsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //PetsViewModel.selectedPet = animals?[indexPath]
    performSegue(withIdentifier: "goToDetalil", sender: nil)
    PetsViewModel.selectedPet = generalAnimalList?[indexPath.row]
    PrototypeLayout.selectedName = PrototypeLayout.imagesLoop[indexPath.row]
    PrototypeLayout.selectedImage = arrayOfImages(PrototypeLayout.imagesLoop)[indexPath.row]
    
    print(indexPath)
  }
  
}

extension PetsController :UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    animalsManager.fetchToken()
    print("\(textFieldOutlet.text)")
    // fetchAnimalType(textFieldOutlet.text ?? "")
    textField.resignFirstResponder() // para que se quite el teclado  y que pierda el foco
    return true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    //animalsManager.fetchToken()
  }
  
  
}
