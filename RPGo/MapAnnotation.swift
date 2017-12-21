//
//  MapAnnotation.swift
//  RPGo
//
//  Created by Felix Plajer on 12/11/17.
//  Copyright © 2017 Felix Plajer. All rights reserved.
//

import UIKit
import Foundation
import MapKit


// annotation for the map that holds an item
class MapAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String? = " "
    let item: Treasure
    
    init(coordinate: CLLocationCoordinate2D, item: Treasure) {
        self.coordinate = coordinate
        self.item = item
        
        super.init()
    }
    
    func annotationView() {
        
    }
}

