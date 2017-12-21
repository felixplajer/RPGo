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

class MapAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String? = " "
    let item: Treasure
    var time: Timer
    
    init(coordinate: CLLocationCoordinate2D, item: Treasure) {
        self.coordinate = coordinate
        self.item = item
        self.time = Timer.init()
        
        super.init()
    }
    func annotationView() {
        
    }
}

