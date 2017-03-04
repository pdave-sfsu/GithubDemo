//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Poojan Dave on 2/27/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

//SearchSettingsViewController is of type UIViewController (parent class)
//also adheres to the SettingsPresentingViewContollerDelegate
class SearchSettingsViewController: UIViewController {

    @IBOutlet weak var starsSlider: UISlider!
    
    //setting property
    var settings: GithubRepoSearchSettings?
    
    //delegate
    weak var delegate: SettingsPresentingViewControllerDelegate?

    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializing the settings to the GithubRepoSearchSettings()
        //Calling init() within GithubRepoSearchSettings
        settings = GithubRepoSearchSettings()
    }

    //cancelButton action
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        //Using the delegate to call the didCancelSettings() within the RepoResultsViewController
        self.delegate?.didCancelSettings()
        
        //dismissing the Settings modal
        dismiss(animated: true) {
            print("Settings modal dismissed: Cancel button pressed")
        }
    }
    
    //saveButton action
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        //Retrieve the value within the slider
        //Cast it as an int (default is float)
        //Set the minStars within settings to value
        self.settings?.minStars = Int(self.starsSlider.value)
        
        //Using the delegate to call the didSaveSettings() within the RepoResultsViewController
        self.delegate?.didSaveSettings(settings: settings!)
        
        //dismissing the Settings modal
        dismiss(animated: true) { 
            print("Settings modal dismissed: Save button pressed")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
