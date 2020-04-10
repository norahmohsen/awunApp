//
//  CollectionViewCell.swift
//  collectionViewHome
//
//  Created by Norah on 19/09/2019.
//  Copyright © 2019 Nourah. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageViewSection: UIImageView!
    
}

class CollectionViewCellProvider: UICollectionViewCell {
    @IBOutlet weak var imageViewSection: UIImageView!
    @IBOutlet weak var label: UILabel!
    
}
