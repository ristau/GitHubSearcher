//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD


// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, SettingsPresentingViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingButton: UIButton!
  
  
  
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
      
        settingButton.layer.cornerRadius = 4
      
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // MARK: - TABLEVIEW METHODS 
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
    
    let repo = repos[indexPath.row]
    
    cell.repo = repo
    
    return cell
  }
  
  
    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
              
                self.repos.append(repo)
                print(repo)
            }
          
          self.tableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error!)
        })
    }

func didSaveSettings(settings: GithubRepoSearchSettings) {

    self.searchSettings = settings
    print("New Settings - Min stars: \(searchSettings.minStars)")
    doSearch()
}

func didCancelSettings() {
  print("did cancel") 
}


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
    let navController = segue.destination as! UINavigationController
    let settingsVc = navController.topViewController as! SettingViewController
    settingsVc.settings = self.searchSettings
    settingsVc.settingsDelegate = self
  
  }
  
  
}



// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
