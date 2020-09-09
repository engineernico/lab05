//
//  LocationTableViewController.swift
//  lab05
//
//  Created by user176171 on 9/9/20.
//  Copyright © 2020 user176171. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationTableViewController: UITableViewController, NewLocationDelegate, CLLocationManagerDelegate {
    
    
    weak var mapViewController: MapViewController?
    var locationList = [LocationAnnotation]()
    var geofence: CLCircularRegion?
    var locationManager: CLLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var location = LocationAnnotation(title: "Monash Uni - Caulfield",
                                          subtitle: "The Caulfield Campus of the Uni",
                                          lat: -37.877623, long: 145.045374)
        locationList.append(location)
        mapViewController?.mapView.addAnnotation(location)
        
        location = LocationAnnotation(title: "Monash Uni - Clayton",
                                      subtitle: "The Clayton Campus of the Uni",
                                      lat: -37.9105238, long: 145.1362182)
        locationList.append(location)
        mapViewController?.mapView.addAnnotation(location)
        print(location.coordinate)
        geofence = CLCircularRegion(center: location.coordinate, radius: 500,
                                    identifier: "geofence")
        geofence?.notifyOnExit = true
        geofence?.notifyOnEntry = true
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoring(for: geofence!)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Geofencing Methods
    func locationManager(_ manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        let alert = UIAlertController(title: "Movement Detected!", message:
            "You have left Monash Caulfield", preferredStyle:
            UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style:
            UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locationList.count
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "locationCell", for: indexPath)
        let annotation = self.locationList[indexPath.row]
        
        cell.textLabel?.text = annotation.title
        cell.detailTextLabel?.text = "Lat: \(annotation.coordinate.latitude) Long: \(annotation.coordinate.longitude)"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        mapViewController?.focusOn(annotation: self.locationList[indexPath.row])
        if let mapVC = mapViewController {
            splitViewController?.showDetailViewController(mapVC, sender: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationSegue" {
            let controller = segue.destination as! NewLocationViewController
            controller.delegate = self
        }
    }
    // MARK: - New Location Delegate
    func locationAnnotationAdded(annotation: LocationAnnotation) {
        locationList.append(annotation)
        tableView.insertRows(at: [IndexPath(row: locationList.count - 1,
                                            section: 0)], with: .automatic)
        mapViewController?.mapView.addAnnotation(annotation)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
