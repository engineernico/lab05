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

class LocationTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    weak var mapViewController: MapViewController?
    var locationList = [Exhibit]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var location = Exhibit(title: "Monash Uni - Caulfield",
                                          subtitle: "The Caulfield Campus of the Uni",
                                          lat: -37.877623, long: 145.045374)
        locationList.append(location)
        mapViewController?.mapView.addAnnotation(location)
        
        location = Exhibit(title: "Monash Uni - Clayton",
                                      subtitle: "The Clayton Campus of the Uni",
                                      lat: -37.9105238, long: 145.1362182)
        locationList.append(location)
        mapViewController?.mapView.addAnnotation(location)
       
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let newlocvc = segue.destination as? NewLocationViewController
//        newlocvc.delegate = self
//    }
    

    
    
    
    
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
    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addLocationSegue" {
//            let controller = segue.destination as! NewLocationViewController
//            controller.delegate = self
//        }
//    }
//    // MARK: - New Location Delegate
//    func locationAnnotationAdded(annotation: Exhibit) {
//        locationList.append(annotation)
//        tableView.insertRows(at: [IndexPath(row: locationList.count - 1,
//                                            section: 0)], with: .automatic)
//        mapViewController?.mapView.addAnnotation(annotation)
//    }
    
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
