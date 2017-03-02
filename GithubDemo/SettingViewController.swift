//
//  SettingViewController.swift
//  GithubDemo
//
//  Created by Barbara Ristau on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController {

  weak var delegate: SettingsPresentingViewControllerDelegate?
  
  var settings: GithubRepoSearchSettings!
  var minStars: Int?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      settings = GithubRepoSearchSettings()
      settings?.minStars = 3 // update this
      
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func saveButtonTapped(_ sender: UIBarButtonItem){
    self.delegate?.didSaveSettings(settings: settings) 
    dismiss(animated: true, completion: nil)
  }

  
  @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    self.delegate?.didCancelSettings()
    
    dismiss(animated: true, completion: nil)
  }
  

   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   // }

}


protocol SettingsPresentingViewControllerDelegate: class {
  func didSaveSettings(settings: GithubRepoSearchSettings)
  func didCancelSettings()
}
