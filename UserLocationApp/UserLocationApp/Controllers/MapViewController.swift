//
//  MapViewController.swift
//  locationApp
//
//  Created by admin on 02/08/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapViewModelObj = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocation()
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            mapViewModelObj.getWeatherData(for: location)
            mapViewModelObj.getAddressFromCoordinates(location: location)
            let span = MKCoordinateSpanMake(0.0005, 0.0005)
            let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region = MKCoordinateRegionMake(myLocation, span)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        annotationView.image = #imageLiteral(resourceName: "pin")
        annotationView.canShowCallout = true
        mapView.userLocation.title = ""
        if let customView = Bundle.main.loadNibNamed("calloutView", owner: self, options: nil)?.first as? CalloutView
        {
            let calloutObj = mapViewModelObj.getCallOutValues()
            customView.userName.text = "Name: \(calloutObj.name)"
            customView.userAddress.text = "Address: \(calloutObj.address ?? "")"
            customView.dateAndTime.text = "Date and Time: \(calloutObj.date)"
            customView.weather.text = "Weather: \(calloutObj.weather ?? "")"
            annotationView.detailCalloutAccessoryView = customView
        }
        return annotationView
    }
}
