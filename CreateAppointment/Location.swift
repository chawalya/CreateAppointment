//
//  Location.swift
//  CreateAppointment
//
//  Created by Patchariya Piyaaromrat on 24/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import MapKit
import UIKit
protocol MyProtocol
{
    func setValue(type: String)
}
class Location: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var mTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var locations = [MKMapItem]()
    var valueToPass:String!
    override func viewDidLoad() {
        searchBar.delegate = self
        searchBar.placeholder = "Enter Location"
    }
  
    
    
    class Location: NSObject {
        var locationName: String!
        var location: String!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result") as? LocationTableViewCell
        cell?.myLocationNameLabel.text = locations[indexPath.row].name
        cell?.myLocationLabel.text = locations[indexPath.row].placemark.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! LocationTableViewCell
        
        valueToPass = currentCell.myLocationNameLabel.text
        

        performSegue(withIdentifier: "titleLocation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "titleLocation") {

            var viewController = segue.destination as! ViewController
            viewController.passedValue = valueToPass
            
           
        }
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searching", searchBar.text!)
        searchBar.becomeFirstResponder()
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { response, _ in
            if response == nil {
                print("ERROR")
            } else {
                // Getting data
                guard (response?.mapItems.count)! > 0 else { return }
                self.locations = response!.mapItems
            }
        }
        mTableView.reloadData()
    }
}
