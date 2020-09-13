//
//  MapViewController.swift
//  lab05
//
//  Created by user176171 on 9/9/20.
//  Copyright © 2020 user176171. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var isMap : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gardens = Exhibit(title: "Royal Botanic Gardens", subtitle: "General marker to zoom initial map view.", lat: -37.830369, long: 144.979606)
        self.focusOn(annotation: gardens)
                
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func focusOn(annotation: MKAnnotation) {
        mapView.selectAnnotation(annotation, animated: true)
        
        let zoomRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800,
                                            longitudinalMeters: 1000)
        mapView.setRegion(mapView.regionThatFits(zoomRegion), animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
