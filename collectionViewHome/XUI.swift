//
//  XUI.swift
//  collectionViewHome
//
//  Created by AlHassan Al-Mehthel on 06/04/1441 AH.
//  Copyright © 1441 Nourah. All rights reserved.
//

import UIKit



extension UIView {
    
    func generalGradiantView() {
        let topColor = UIColor(red: 242.0 / 255.0, green: 177.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 1.0, green: 246.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
        self.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
    }
    
    
}
