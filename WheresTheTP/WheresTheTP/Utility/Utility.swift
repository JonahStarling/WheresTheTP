//
//  Utility.swift
//  WheresTheTP
//
//  Created by Jonah Starling on 3/23/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    static func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
