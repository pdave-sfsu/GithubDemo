//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Poojan Dave on 2/27/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController, SettingsPresentingViewControllerDelegate {

    var settings: GithubRepoSearchSettings?
    
    weak var delegate: SettingsPresentingViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings = GithubRepoSearchSettings()
        settings?.minStars = 3

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.delegate?.didCancelSettings()
        
        dismiss(animated: true) {
            print("Hello")
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        self.delegate?.didSaveSettings(settings: settings!)
        
    }
    
    
    internal func didCancelSettings() {
        
        
    }
    
    internal func didSaveSettings(settings: GithubRepoSearchSettings) {
        print("hello")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}


