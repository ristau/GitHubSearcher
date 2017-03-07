//
//  SettingViewController.swift
//  GithubDemo
//
//  Created by Barbara Ristau on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit


protocol SettingsPresentingViewControllerDelegate: class {
  func didSaveSettings(settings: GithubRepoSearchSettings)
  func didCancelSettings()
}


class SettingViewController: UIViewController {

  var settingsDelegate: SettingsPresentingViewControllerDelegate?
  
  var settings: GithubRepoSearchSettings!
  var minStars: Int?
  
  @IBOutlet weak var minStarsSlider: UISlider!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      settings = GithubRepoSearchSettings()

    }
  
  
  @IBAction func saveButtonTapped(_ sender: UIBarButtonItem){
    
    dismiss(animated: true) {
      
      self.settings.minStars = Int(self.minStarsSlider.value)
      self.settingsDelegate?.didSaveSettings(settings: self.settings)
    }
    
    
    
  }

  
  @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
  
    dismiss(animated: true) {
      self.settingsDelegate?.didCancelSettings()
    }
    
  }
  

   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   // }

}

