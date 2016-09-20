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
        return UIColor.lightGray
    }
    
    var textColor: UIColor {
        return UIColor.black
    }
    
    var font: UIFont {
        return .systemFont(ofSize: 16)
    }
}


class MovieCollectionViewCell: UICollectionViewCell {
    
    fileprivate var delegate: MovieTextCellDelegate?
    fileprivate var dataObject: MoviesLibrary?
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.textColor = UIColor.lightGray
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
            DispatchQueue.global(qos: .userInteractive).async(execute: {
                if let data = try? Data(contentsOf: URL(string: imgUrl)!) {
                    image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.thumbnail.image = image
                    }
                }
            })
            /*DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: { () -> Void in
                if let data = try? Data(contentsOf: URL(string: imgUrl)!) {
                    image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.thumbnail.image = image
                    }
                }
                
            })*/
        }
        
        self.titleLabel.textColor = delegate?.titleColor
        self.titleLabel.font = delegate?.font
    }
    
}


