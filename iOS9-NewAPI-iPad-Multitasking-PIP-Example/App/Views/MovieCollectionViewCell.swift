//
//  MovieCollectionViewCell.swift
//  iOS9-NewAPI-iPad-Multitasking-PIP-Example
//
//  Created by Wlad Dicario on 15/09/2015.
//  Copyright © 2015 Sweefties. All rights reserved.
//

import UIKit

protocol MovieTextCellDataSource {
    var title: String { get }
}

protocol MovieTextCellDelegate {
    var titleColor: UIColor { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
}

extension MovieTextCellDelegate {
    
    var titleColor: UIColor {
        return .lightGrayColor()
    }
    
    var textColor: UIColor {
        return .blackColor()
    }
    
    var font: UIFont {
        return .systemFontOfSize(16)
    }
}


class MovieCollectionViewCell: UICollectionViewCell {
    
    private var delegate: MovieTextCellDelegate?
    private var dataObject: MoviesLibrary?
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.textColor = .lightGrayColor()
    }
    
    /**
    Configure the current Cell (Item) with data Object Model and delegate protocol.
    - parameter dataObject:     The Movie Model object to layout.
    - parameter delegate:       The MovieTextCellDelegate optionnal protocol.
    - returns: The current Cell setted a new object model with `dataObject` from dataObject.
    */
    func configure(withDataSource dataObject: MoviesLibrary, delegate: MovieTextCellDelegate?) {
        self.dataObject = dataObject
        self.delegate = delegate
        
        self.titleLabel.text = dataObject.title
        
        /// simple get image from url (only for this demo project..)
        /// CAUTION : You must preferred one helper class with performed methods (by example : cache, NSURLSession, NSURLResponse.. and MANAGE CACHE MEMORY!!!)
        var image = UIImage(named: "first")
        if let imgUrl = dataObject.thumbnailUrl as String? {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                if let data = NSData(contentsOfURL: NSURL(string: imgUrl)!) {
                    image = UIImage(data: data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.thumbnail.image = image
                    }
                }
                
            })
        }
        
        self.titleLabel.textColor = delegate?.titleColor
        self.titleLabel.font = delegate?.font
    }
    
}


