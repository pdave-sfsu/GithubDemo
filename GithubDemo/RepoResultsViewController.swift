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
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //tableView
    @IBOutlet weak var tableView: UITableView!
    
    //searchBar
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    
    //repos Property initialized to empty
    var repos: [GithubRepo]! = []

    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the tableView delegate and dataSource to self
        tableView.delegate = self
        tableView.dataSource = self
        
        //estimatedRowHeight
        tableView.estimatedRowHeight = 100
        //set the tableViewCells to be resizable
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        //Shows progressHUD
        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
                
                //add the repo to the global repo property
                self.repos.append(repo)
            }
            
            //reload the Data in the tableView
            self.tableView.reloadData()

            //hide the progressHUD
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error ?? 0)
        })
    }
    
    //numberOfRowsInSection
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos {
            return repos.count
        } else {
            return 0
        }
    }
    
    //cellForRowAt
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create the cell, cast as GitHubRepoCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitHubRepoCell", for: indexPath) as! GitHubRepoCell
        
        //retrieve the proper repo
        let repo = repos[indexPath.row]
        
        //nameLabel is set to name
        cell.nameLabel.text = repo.name
        cell.descriptionLabel.text = repo.repoDescription
        cell.ownerLabel.text = repo.ownerHandle
        
        //set the forks and stars count
        let forksCount = String(describing: repo.forks!)
        cell.forksButton.setTitle(forksCount, for: UIControlState.normal)
        let starsCount = String(describing: repo.stars!)
        cell.starsButton.setTitle(starsCount, for: UIControlState.normal)
        
        //Added photo
        if let avatarPhoto = repo.ownerAvatarURL{
            let avatarPhotoURL = URL(string: avatarPhoto)
            cell.avatarImageView.setImageWith(avatarPhotoURL! as URL)
        }
        
        return cell
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
