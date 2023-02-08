//
//  AddVC.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 08/02/2023.
//

import MapKit
import UIKit
class AddVC:UIViewController{
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var goButton: UIButton!
    private let hideKeyboardDelegate = Keyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        address.delegate = hideKeyboardDelegate
        url.delegate = hideKeyboardDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }

    @IBAction func GoButton(_ sender: Any) {
        guard isAllDataValid() else { return }
        geocode(address: address.text!) { (location) in
            self.gotoNextScreen(location: location)
        }
    }
    
    private func isAllDataValid() -> Bool {
        if (address.text!.isEmpty) {
            showErrorAlert(message: "Please enter a valid address")
            return false
        } else if (!url.text!.isValidUrl()) {
            showErrorAlert(message: "Please enter a valid url")
            return false
        }
        
        return true
    }
    
    private func geocode(address: String, onSuccess: @escaping (CLLocationCoordinate2D) -> Void) {
        isActivityInProgress(inProgress: true)
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            self.isActivityInProgress(inProgress: false)
            guard let placemarks = placemarks, placemarks.count > 0, placemarks.first?.location != nil else {
                self.showErrorAlert(message: "Unable to find location for the address")
                return
            }
            
            onSuccess(placemarks.first!.location!.coordinate)
        }
    }
    
    private func gotoNextScreen(location: CLLocationCoordinate2D) {
        let studentLocation = StudentLocation(address: address.text!,
                                              url: url.text!,
                                              userId: AppData.userId,
                                              location: location)
        self.performSegue(withIdentifier: "ShowLocationOnMap", sender: studentLocation)
    }
    private func isActivityInProgress(inProgress: Bool) {
        goButton.isEnabled = !inProgress
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let studentLocation = sender as! StudentLocation
        let ConfirmLocationVC = segue.destination as! ConfirmLocationVC
        ConfirmLocationVC.studentLocation = studentLocation
    }
}
