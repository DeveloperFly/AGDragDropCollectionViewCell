//
//  BottomCollectionViewCell.swift
//  AGDragDropCollectionViewCell
//
//  Created by Aman Gupta on 28/12/17.
//  Copyright © 2017 Developer Fly. All rights reserved.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Configure Cell
    func configureCell(image: UIImage) {
        self.imageView.image = image
    }
    
}
