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

class ViewController: UIViewController {
  
  let animalsManager = AnimalsMAnager()
   
  var animaPerType:[Animal]?
  var animalList:[Animal]? //🎉
  
  
  // Mark: - OUTLETS ‼️
  
  @IBOutlet weak var textFieldOutlet: UITextField!
  @IBOutlet var tableview:UITableView!
  
  
  override func viewDidLoad() {
    
    
    
    tableview.delegate = self
    tableview.dataSource = self
    let nib = UINib (nibName: "PetCell", bundle: nil)
    tableview.register(nib, forCellReuseIdentifier: "PetCell")
    //allAnimals()
    animalsManager.fetchToken()
    
    
   
    
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
  //    animalsManager.searchType(type: type,
  //                                success:{(infoType) in
  //                                  self.animals = infoType.animal
  //
  //                                  self.tableview.reloadData()
  //                                  print("in succes block \n\n")})
  //
  //  }

}

// Mark: - DATASOURCE ‼️

extension ViewController: UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    PrototypeLayout.images4Loop.count
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
    return  arrayOfImages(PrototypeLayout.images4Loop).count
     // return animalList?.count ?? 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   

    let cell = tableView.dequeueReusableCell(withIdentifier: myReuseIdentifier, for: indexPath) as! PetCell
    
    cell.imageCell.image = arrayOfImages(PrototypeLayout.images4Loop)[indexPath.row]
    cell.labelCell.text = PrototypeLayout.images4Loop[indexPath.row]
    cell.labelCell.textColor = .oceansBlue()
    
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
  
}

// Mark: - DELEGATE ‼️
extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //PetsViewModel.selectedPet = animals?[indexPath]
    performSegue(withIdentifier: "goToDetalil", sender: nil)
    PetsViewModel.selectedPet = animalList?[indexPath.row]
    PrototypeLayout.selectedName = PrototypeLayout.images4Loop[indexPath.row]
    PrototypeLayout.selectedImage = arrayOfImages(PrototypeLayout.images4Loop)[indexPath.row]

    print(indexPath)
  }
  
}
 

extension ViewController :UITextFieldDelegate {
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
