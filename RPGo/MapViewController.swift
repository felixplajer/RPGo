//
//  MapViewController.swift
//  RPGo
//
//  Created by Felix Plajer on 12/11/17.
//  Copyright © 2017 Felix Plajer. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

// holds an item + its map location
struct Treasure {
    let item: Item
    let location: CLLocation
    let id: Int
}

class MapViewController: ViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var items = [Treasure]() // all items on map
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var haveFirstLocation = false
    
    // generate nearby random coords
    func randCoords(lat: Double, long: Double) -> CLLocation { // roughly a square mile cube
        var rand =  Double(arc4random()) / Double(UINT32_MAX)
        rand = ((rand * 2 - 1) / 69) / 5000
        let randLat = lat + rand
        
        rand =  Double(arc4random()) / Double(UINT32_MAX)
        rand = ((rand * 2 - 1) / 69) / 5000
        let randLong = long + rand
        
        return CLLocation(latitude: randLat, longitude: randLong)
    }
    
    // setup the location of the items
    func setupLocations(userLocation: CLLocation) {
        let userCoords = userLocation.coordinate
        let userLat = userCoords.latitude.magnitude
        let userLong = userCoords.longitude.magnitude

        for num in 1...20 {
            let value = arc4random_uniform(11)
            let type = arc4random_uniform(3)
            let rarity = arc4random_uniform(3)
            var typeEnum : Item.ItemType
            var image : String
            switch type {
            case 0:
                typeEnum = .Attack
                image = "Item__07"
            case 1:
                typeEnum = .Defense
                image = "Item__24"
            default:
                typeEnum = .Health
                image = "Item__29"
            }

            let item = Item(image: image, type: typeEnum, value: Int(value + value*(rarity/2)) , rarity: Int(rarity))

            let treasure = Treasure(item: item, location: randCoords(lat: userLat, long: userLong), id: num)
            items.append(treasure)
            NSLog("doooooot")
        }

        for item in items {
            let annotation = MapAnnotation(coordinate: item.location.coordinate, item: item)
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
<<<<<<< HEAD
    func removeAnnotation(annotation: MapAnnotation)
    {
        mapView.removeAnnotation(annotation)
    }
    
    
=======
    // show that item has been found (when clicked)
>>>>>>> cfe21c675e9502127cd161a1e2460f2225588681
    func showInfoView(treasure: Treasure) {
        let alert = UIAlertController(title: "You've found an item!", message: "Visit your inventory to check it out.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
<<<<<<< HEAD
        
        
        
        
//        setupLocations()
        
//        self.mapView.addAnnotation(annotation)
    }
=======
>>>>>>> cfe21c675e9502127cd161a1e2460f2225588681

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        player.save()
    }

    
    // style map pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MapAnnotation {
            let pinAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            pinAnnotationView.markerTintColor = .purple
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesWhenAdded = true
            
            let deleteButton = UIButton(type: UIButtonType.custom) as UIButton
            deleteButton.frame.size.width = 44
            deleteButton.frame.size.height = 44
            deleteButton.setImage(UIImage(named: "tick"), for: .normal)
            deleteButton.setTitle("Collect", for: .normal)
            deleteButton.setTitleColor(.black, for: .normal)
            
            return pinAnnotationView
        }
        return nil
        
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    // keep track of user's location + generate item
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            let location = locations.last!
            self.userLocation = location
            let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.region = region
            
            if !haveFirstLocation {
                haveFirstLocation = true
                
                let value = Int(arc4random_uniform(10) + 1)
                let type = arc4random_uniform(2)
                let rarity = Int(arc4random_uniform(3))
                var typeEnum : Item.ItemType
                var image : String
                switch type {
                case 0:
                    typeEnum = .Attack
                    image = "Item__07"
                case 1:
                    typeEnum = .Defense
                    image = "Item__24"
                default:
                    typeEnum = .Health
                    image = "Item__29"
                }
                
<<<<<<< HEAD
                let item = Item(image: image, type: typeEnum, value: Int(value + value*(rarity/2)) , rarity: Int(rarity))
//                let treasure = Treasure(item: item, location: randCoords(lat: userLat, long: userLong), id: num)
//                items.append(treasure)
                var addlat = 0.0018
                var addlong = 0.0018
                let ranup = Int(arc4random_uniform(3)) - 2
                addlat = addlat * Double(ranup) * Double(rarity)
                let ranu = Int(arc4random_uniform(3)) - 2
                addlong = addlong * Double(ranu) * Double(rarity)
                let newLoc = CLLocation(latitude: location.coordinate.latitude + addlat, longitude: location.coordinate.longitude + addlong)
=======
                let item = Item(image: image, type: typeEnum, value: Int(value))
                
            
                let newLoc = CLLocation(latitude: location.coordinate.latitude + 0.0015, longitude: location.coordinate.longitude)
>>>>>>> cfe21c675e9502127cd161a1e2460f2225588681
                let annotation = MapAnnotation(coordinate: newLoc.coordinate, item: Treasure(item: item, location: location, id: 1))
                mapView.addAnnotation(annotation)
<<<<<<< HEAD
                
    //            setupLocations(userLocation: location)
=======
>>>>>>> cfe21c675e9502127cd161a1e2460f2225588681
            }
        }
    }

    // collect item when clicking on an annotation/pin
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        NSLog("this tooooo")
        let coordinate = view.annotation!.coordinate
        
        if userLocation!.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) < Double(5000) {

            if let mapAnnotation = view.annotation as? MapAnnotation {
                player.items.append(mapAnnotation.item.item)

                showInfoView(treasure: mapAnnotation.item)
                mapView.removeAnnotation(view.annotation!)
            }
        }
        
    }
}

