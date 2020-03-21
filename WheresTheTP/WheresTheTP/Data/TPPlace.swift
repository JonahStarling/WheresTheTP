//
//  TPPlace.swift
//  WheresTheTP
//
//  Created by Jonah Starling on 3/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import Foundation
import GooglePlaces

class TPPlace {
    let place: GMSPlace
    let stock: TPStock
    
    init(place: GMSPlace, stock: TPStock) {
        self.place = place
        self.stock = stock
    }
    
    init(place: GMSPlace) {
        self.place = place
        self.stock = TPStock.UnknownStock
    }
}

enum TPStock {
    case FullStock
    case SomeStock
    case NoStock
    case UnknownStock
}
