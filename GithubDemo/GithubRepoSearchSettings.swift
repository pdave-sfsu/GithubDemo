//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

// Model class that represents the user's search settings
//Can be considered a container class
class GithubRepoSearchSettings {
    
    //String that is searched for
    var searchString: String?
    
    //minimum stars
    //Actual count of stars
    var minStars = 0
    
    //Language choice
    var language: String?
    
    //init()
    //When the class is called, this is the constructor to initalize it
    init() {
        
    }
}
