//
//  MoviesLibrary.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 15/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import UIKit

class MoviesLibrary: NSObject {

    var title:String
    var descriptionText:String
    var thumbnailUrl: String
    var movieUrl: String
    
    override init() {
        title = "unknown"
        descriptionText = "unknown"
        thumbnailUrl = ""
        movieUrl = ""
        super.init()
    }
    
    init(title:String, descriptionText:String, thumbnailUrl:String, movieUrl:String) {
        self.title = title
        self.descriptionText = descriptionText
        self.thumbnailUrl = thumbnailUrl
        self.movieUrl = movieUrl
        super.init()
    }
    
}
