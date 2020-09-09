//
//  SceneDelegate.swift
//  lab05
//
//  Created by user176171 on 9/9/20.
//  Copyright © 2020 user176171. All rights reserved.
//

import UIKit
import MapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var geofence: CLCircularRegion?
    var mvc : MapViewController?
    var locationManager: CLLocationManager = CLLocationManager()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let splitViewController = window?.rootViewController as! UISplitViewController
        splitViewController.preferredDisplayMode = .allVisible
        let navigationController = splitViewController.viewControllers.first as!
        UINavigationController
        let locationTableViewController = navigationController.viewControllers.first as!
        LocationTableViewController
        let mapViewController = splitViewController.viewControllers.last as! MapViewController
        mvc = mapViewController
        
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
        
        
        locationTableViewController.mapViewController = mapViewController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

extension SceneDelegate {
    
    func handle(message : String) {
        print(message)
        if mvc?.viewIfLoaded?.window != nil {
            let alert = UIAlertController(title: "You're on the move!", message: message, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
            
        }

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
