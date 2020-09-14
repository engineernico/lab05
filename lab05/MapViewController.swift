//
//  MapViewController.swift
//  lab05
//
//  Created by user176171 on 9/9/20.
//  Copyright © 2020 user176171. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate, NewLocationDelegate {
    
    var isMap : Bool = true
    var currentLocation : CLLocationCoordinate2D?
    var locationTableVC: LocationTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Setup and zoom to initial view
        let gardens = Exhibit(title: "Royal Botanic Gardens", subtitle: "General marker to zoom initial map view.", lat: -37.830369, long: 144.979606)
        self.focusOn(annotation: gardens)
        
        // Setup gesture recognition for adding exhibits
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func focusOn(annotation: MKAnnotation) {
        mapView.selectAnnotation(annotation, animated: true)
        
        let zoomRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800,
                                            longitudinalMeters: 1000)
        mapView.setRegion(mapView.regionThatFits(zoomRegion), animated: true)
        mapView.isZoomEnabled = true
    }
    
    @objc func tapped(gestureRecognizer : UITapGestureRecognizer) {
        print("Tapped")
    }
    
    @objc func longPressed(gestureRecognizer: UILongPressGestureRecognizer) {
        
        
        if (gestureRecognizer.state == .began) {
            let location = gestureRecognizer.location(in: mapView)
            currentLocation  = mapView.convert(location, toCoordinateFrom: mapView)
            
            print(currentLocation ?? "Not found current Location")
            self.performSegue(withIdentifier: "addLocationFromMapSegue", sender: self)
        }
        // Add annotation:
        //        let annotation = MKPointAnnotation()
        //        annotation.coordinate = coordinate
        //        mapView.addAnnotation(annotation)
    }
    
    
    // MARK: - New Location Delegate
       func locationAnnotationAdded(annotation: Exhibit) {
           print("Adding new location to table.")
        locationTableVC!.locationList.append(annotation)
        locationTableVC!.tableView.insertRows(at: [IndexPath(row: locationTableVC!.locationList.count - 1,
                                               section: 0)], with: .automatic)
        mapView.addAnnotation(annotation)
       }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newLocView = segue.destination as? NewLocationViewController  else { return   }
        newLocView.currentLocation = currentLocation
        newLocView.delegate = self
    }


    
}
