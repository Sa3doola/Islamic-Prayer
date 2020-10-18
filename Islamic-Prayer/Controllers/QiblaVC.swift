//
//  QiblaVC.swift
//  Islamic-Prayer
//
//  Created by sa3doola on 9/13/20.
//  Copyright © 2020 saad sherif. All rights reserved.
//

import UIKit
import CoreLocation

class QiblaVC: UIViewController {
    
    
    @IBOutlet weak var finalBaseImage: UIImageView!
    @IBOutlet weak var CityName: UILabel!
    
    let locationDelegate = LocationDelegate()
    
    var latestLocation: CLLocation? = nil
    var yourLocationBearing: CGFloat { return latestLocation?.bearingToLocationRadian(self.yourLocation) ?? 0 }
    
    var yourLocation: CLLocation {
        get { return UserDefaults.standard.currentLocation }
        set { UserDefaults.standard.currentLocation = newValue }
    }
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.startUpdatingLocation()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    private func orientationAdjustment() -> CGFloat {
        let isFaceDown: Bool = {
            switch UIDevice.current.orientation {
            case .faceDown: return true
            default: return false
            }
        }()
        
        let adjAngle: CGFloat = {
            
             let ifOrientation = { () -> UIInterfaceOrientation in
                if #available(iOS 13, *)  {
                    return self.view.window?.windowScene?.interfaceOrientation ?? .unknown
                }
                return UIApplication.shared.statusBarOrientation
            }
            switch ifOrientation() {
            case .landscapeLeft:  return 90
            case .landscapeRight: return -90
            case .portrait, .unknown: return 0
            case .portraitUpsideDown: return isFaceDown ? 180 : -180
            @unknown default:
                return 0
            }
        }()
        return adjAngle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CityName.text = ChossenCity
        locationManager.delegate = locationDelegate
        
        locationDelegate.locationCallback = { location in
            self.latestLocation = location
        }
        
        locationDelegate.headingCallback = { newHeading in
            
            func computeNewAngle(with newAngle: CGFloat) -> CGFloat {
                let heading: CGFloat = {
                    let originalHeading = self.yourLocationBearing - newAngle.degreesToRadians
                    switch UIDevice.current.orientation {
                    case .faceDown: return -originalHeading
                    default: return originalHeading
                    }
                }()
                
                return CGFloat(self.orientationAdjustment().degreesToRadians + heading)
            }
            
            UIView.animate(withDuration: 0.5) {
                let angle = computeNewAngle(with: CGFloat(newHeading))
                self.finalBaseImage.transform = CGAffineTransform(rotationAngle: angle)
                
            }
        }
    }
    
}
