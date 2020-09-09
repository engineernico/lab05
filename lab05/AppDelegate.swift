//
//  AppDelegate.swift
//  lab05
//
//  Created by user176171 on 9/9/20.
//  Copyright © 2020 user176171. All rights reserved.
//

import UIKit
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    
    
    var geofence: CLCircularRegion?
    var locationManager: CLLocationManager = CLLocationManager()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        let location = LocationAnnotation(title: "Monash Uni - Clayton",
                                          subtitle: "The Clayton Campus of the Uni",
                                          lat: -37.9105238, long: 145.1362182)
        
        geofence = CLCircularRegion(center: location.coordinate, radius: 500,
                                    identifier: "geofence")
        geofence?.notifyOnExit = true
        geofence?.notifyOnEntry = true
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoring(for: geofence!)
        
        return true
    }
    
    
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate {
    
    func handle(message : String) {
       
        if let mapView = UIApplication.topViewController() as? MapViewController {
            print("YAAHH")
        } else {
            if (UIApplication.topViewController() is MapViewController) {
                print("maybe")
            }
        }
        
        print(type(of: UIApplication.topViewController()))
        
        let alert = UIAlertController(title: "You're on the move!", message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
            
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            handle(message: "Currently entering Monash Clayton")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            handle(message: "Currently leaving Monash Clayton")
        }
    }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let navigationController = controller as? UINavigationController {
//            return topViewController(controller: navigationController.visibleViewController)
//        }
//        if let tabController = controller as? UITabBarController {
//            if let selected = tabController.selectedViewController {
//                return topViewController(controller: selected)
//            }
//        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}
