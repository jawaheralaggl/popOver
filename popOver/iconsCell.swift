//
//  iconsCell.swift
//  popOver
//
//  Created by Jawaher Alagel on 9/5/20.
//  Copyright © 2020 Jawaher Alaggl. All rights reserved.
//

import UIKit

class iconsCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconName: UILabel!
    
    static let identifier =  "iconsCell"
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // imageView.layer.cornerRadius = 20
        }
        
 
        public func configure(with image: UIImage, text: String) {
            iconImage.image = image
            iconName.text = text
        }
        
        static func nib() -> UINib {
            return UINib(nibName: "iconsCell", bundle: nil)
        }
        
    }

