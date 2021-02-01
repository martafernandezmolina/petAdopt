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
  
  
  // MARK: - GLOBAL VARS
  let animalsManager = AnimalsMAnager()
  var generalAnimalList:[Animals]?
  

  // MARK: - OUTLETS ‼️
  
  @IBOutlet weak var textFieldOutlet: UITextField!
  @IBOutlet var tableview:UITableView!
  
  override func viewDidLoad() {
    
    tableview.delegate = self
    tableview.dataSource = self
    let nib = UINib (nibName: "PetCell", bundle: nil)
    tableview.register(nib, forCellReuseIdentifier: "PetCell")
   // AnimalsMAnager.fetchPassword()
   
    fetchAnimals()
    self.title = "PET ADOPT 🐕"
    self.tableview.addSubview(refreshTableveView)
    
  }
  
  
 var refreshTableveView:UIRefreshControl{
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(PetsController.refreshData), for: .valueChanged)
    refreshControl.tintColor = .oceansBlue()
    return refreshControl
  }
 
  
  @objc func refreshData(){

    fetchAnimalType("cat")
    self.tableview.reloadData()
    refreshTableveView.endRefreshing()
    
  }
  override func viewWillAppear(_ animated: Bool) {
    
    fetchAnimals()
  }
  override func viewWillDisappear(_ animated: Bool) {
   
   // fetchAnimalType("horse")
  }

}

// Mark: - DATASOURCE ‼️

extension PetsController: UITableViewDataSource{

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return generalAnimalList?.count ?? 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: myReuseIdentifier, for: indexPath) as! PetCell
    
    
    if let animalsInformation = generalAnimalList?[indexPath.row]{
      cell.labelCell.textColor = .oceansBlue()
      cell.labelCell.text = animalsInformation.name
      cell.descriptionPet.text = animalsInformation.gender
      
      for photos in animalsInformation.photos {
        if let urlToImage = photos.medium {
          if let url = URL (string: urlToImage){
            cell.imageCell.af.setImage(withURL: url)
          }
        }
      }
    }
    
    
    return cell
  }
    
  func arrayOfImages(_ image:[String]) -> [UIImage]{
    var imageArray = [UIImage]()
    image.forEach { img in
      if let image = UIImage(named: img){
        imageArray.append(image)
      }
    }
    return imageArray
  }
  

  func fetchAnimalType(_ type:String){
    animalsManager.searchAnimals(type: type,
                                 success:{(information) in
                                  self.generalAnimalList = information.animals
                                  self.tableview.reloadData()
                                  
                                 })

    
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


// Mark: - DELEGATE ‼️
extension PetsController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //PetsViewModel.selectedPet = animals?[indexPath]
    performSegue(withIdentifier: "goToDetalil", sender: nil)
    PetsViewModel.selectedPet = generalAnimalList?[indexPath.row]
    PrototypeLayout.selectedName = PrototypeLayout.imagesLoop[indexPath.row]
    
    
  }
  
}


extension PetsController :UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textValue = textField.text
    fetchAnimalType(textValue ?? "cat")
    textField.resignFirstResponder()
    return true
  }
}
