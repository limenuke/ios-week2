//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import SwiftSpinner

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
        searchBar.delegate = self
        SwiftSpinner.show("Searching...")
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            SwiftSpinner.hide()
            
            }
        )
        
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        }
        else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        var categories = filters["categories"] as? [String]
        var myDist = filters["distance"] as? Float
        var ifSort : YelpSortMode?
        if (filters["sort"] != nil) {
            ifSort = YelpSortMode(rawValue: filters["sort"] as! Int)
        }
        SwiftSpinner.show("Searching...")
        Business.searchWithTerm(term: "",
                                sort: ifSort,
                                dist: myDist,
                                categories: categories,
                                deals: filters["deals"] as! Bool,
                                completion: {
            (businesses:[Business]?, error: Error?) -> Void in
            
            if (businesses != nil) {
                self.businesses = businesses
                print (self.businesses)
                self.tableView.reloadData()
                
            }
            if (error != nil) {
                print (error.debugDescription)
            }
            SwiftSpinner.hide()
        }
        )
        searchBar.text = "";
   
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print ("Searched \(searchBar.text)")
        SwiftSpinner.show("Searching...")
        Business.searchWithTerm(term: self.searchBar.text!, completion: {
            (businesses:[Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            SwiftSpinner.hide()
            
        })
        self.view.endEditing(true)
        }
    
    
}
