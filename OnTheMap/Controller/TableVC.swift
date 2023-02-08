//
//  TableVC.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 08/02/2023.
//

import Foundation
import UIKit
class TableVC: UIViewController{
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var addNavBar: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
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
                self.table.reloadData()
            } else {
                self.showErrorAlert(message: error?.localizedDescription ?? "Unable to refresh")
            }
        }
    }
    private func onDataRefresh(inProgress: Bool) {
        refresh.isEnabled = !inProgress
        addNavBar.isEnabled = !inProgress
        
    }
}

extension TableVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.studentLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell")!
        cell.textLabel?.text = AppData.studentLocation[indexPath.row].fullName
        cell.detailTextLabel?.text = AppData.studentLocation[indexPath.row].mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: AppData.studentLocation[indexPath.row].mediaURL) {
            openUrl(url: url)
        } else {
            showErrorAlert(message: "No valid URL found")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
