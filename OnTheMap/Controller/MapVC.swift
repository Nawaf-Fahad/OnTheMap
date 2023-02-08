//
//  MapVC.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 08/02/2023.
//

import Foundation
import MapKit
class MapVC: UIViewController{
    var mapAnnotations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addNavBar: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        // Do any additional setup after loading the view.
        setupAnnotations()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        AppClient.logout { (success, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func Refesh(_ sender: Any) {
        onDataRefresh(inProgress: true)
        AppClient.getStudentLocations { (success, error) in
            self.onDataRefresh(inProgress: false)
            if success {
                self.clearAllAnnotations()
                self.setupAnnotations()
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unable to refresh")
            }
        }
    }
    
    private func setupAnnotations() {
        for location in AppData.studentLocation {
            mapAnnotations.append(location.toMKPointAnnotation())
        }
        mapView.addAnnotations(mapAnnotations)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func clearAllAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    private func onDataRefresh(inProgress: Bool) {
        refresh.isEnabled = !inProgress
        addNavBar.isEnabled = !inProgress
        
    }
}

extension MapVC : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reusePin = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusePin) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reusePin)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let mediaUrl = view.annotation?.subtitle! {
                if let validUrl = URL(string: mediaUrl) {
                    openUrl(url: validUrl)
                }
            }
        }
    }
}
