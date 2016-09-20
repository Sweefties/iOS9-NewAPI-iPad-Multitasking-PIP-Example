//
//  MovieViewModel.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 15/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import Foundation
import UIKit

struct MovieViewModel: MovieTextCellDataSource {
    var title = "Movie Index"
}

extension MovieViewModel: MovieTextCellDelegate {
    
    var titleColor: UIColor {
        return UIColor.white
    }
}
