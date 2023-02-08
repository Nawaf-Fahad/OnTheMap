//
//  ConfirmLocationVC.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 08/02/2023.
//

import UIKit
import MapKit
class ConfirmLocationVC : UIViewController{
    var studentLocation: StudentLocation!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setCenter(studentLocation.toCoordinate2D(), animated: false)
        mapView.addAnnotation(studentLocation.toMKPointAnnotation())
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Done(_ sender: Any) {
        doneButton.isEnabled = false
        AppClient.postStudentLocation(studentLocation: studentLocation) { (success, error) in
            self.doneButton.isEnabled = true
            if success {
                self.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unable to save location")
            }
        }
    }
    
}
extension ConfirmLocationVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "PinView"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = true
            pinView!.tintColor = .red
            pinView!.isDraggable = true
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let url = URL(string: view.annotation!.subtitle!!) {
            openUrl(url: url)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        self.studentLocation = self.studentLocation.copy(location: view.annotation!.coordinate)
    }
}
