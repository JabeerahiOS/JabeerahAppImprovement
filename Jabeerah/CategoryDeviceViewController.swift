//
//  CategoryDeviceViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/6/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class CategoryDeviceViewController: UITableViewController, UISearchResultsUpdating{

    var DeviceNamesArray: NSMutableArray = []
    var titlestring: String!
    
    var resultSearchController = UISearchController(searchResultsController: nil)
    var filteredDevices: NSMutableArray = []
    var searchBar = UISearchBar()
    
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      resultSearchController.searchBar.placeholder = "ابحث عن جهاز"
 }
    
        override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationItem.title = titlestring
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.tableView.reloadData()

        self.navigationItem.title = titlestring
        let ref = FIRDatabase.database().reference().child("UserDevices")
        self.navigationController?.navigationBar.tintColor = UIColor.white
       ref.queryOrdered(byChild: "Category").queryEqual(toValue: titlestring)
            .observe(.value, with: { snapshot in
                
                if let dict = snapshot.value as? NSMutableDictionary{
                    
                    //print("dict======print \(dict)")
                    for (key,value) in dict {
                        
                        let mainDict = NSMutableDictionary()
                        mainDict.setObject(key, forKey: "userid" as NSCopying)
                        if let dictnew = value as? NSMutableDictionary {
                            
                            if let metname = dictnew["DeviceName"] as? String
                            {
                                mainDict.setObject(metname, forKey: "DeviceName" as NSCopying)
                            }
                            if let metname = dictnew["Description"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Description" as NSCopying)
                            }
                            if let metname = dictnew["Category"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Category" as NSCopying)
                            }
                            if let metname = dictnew["ImageUrl"] as? String
                            {
                                mainDict.setObject(metname, forKey: "ImageUrl" as NSCopying)
                                
                            }
                            if let metname = dictnew["name"] as? String
                            {
                                mainDict.setObject(metname, forKey: "name" as NSCopying)
                                
                            }
                            if let metname = dictnew["phone"] as? String
                            {
                                mainDict.setObject(metname, forKey: "phone" as NSCopying)
                                
                            }
                            if let metname = dictnew["city"] as? String
                            {
                                mainDict.setObject(metname, forKey: "city" as NSCopying)
                                
                            }
                            if let metname = dictnew["email"] as? String
                            {
                                mainDict.setObject(metname, forKey: "email" as NSCopying)
                                
                            }
                        }
                        //print("mainDict========= \(mainDict)")
                        self.DeviceNamesArray.add(mainDict)
                    }
                }
                self.tableView.reloadData()
            })
        
            
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive
        {
            return self.filteredDevices.count
        }else
        {
            return DeviceNamesArray.count
        }
    }
    

    let storageRef = FIRStorage.storage().reference().child("Devices_Images")
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategotyDeviceCellViewCell
        
      
        if self.resultSearchController.isActive
        {
            if let name = self.filteredDevices[indexPath.row] as? NSMutableDictionary{
                cell.DeviceName.text = name["DeviceName"] as? String
                cell.DeviceProvider.text = name["name"] as? String
                cell.City.text = name["city"] as? String
                //It takes so much to download
                cell.CategoryDeviceImage.downloadedFrom(link: name["ImageUrl"] as! String)
      
            }
        
        } else {
            if let name = DeviceNamesArray[(indexPath as NSIndexPath).row] as? NSMutableDictionary {
                cell.DeviceName.text = name["DeviceName"] as? String
                cell.DeviceProvider.text = name["name"] as? String
                cell.City.text = name["city"] as? String
                //It takes so much to download
                cell.CategoryDeviceImage.downloadedFrom(link: name["ImageUrl"] as! String)
                
                           }
        
        }
       
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async { [unowned self] in
            let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "DeviceDetailsViewController") as! DeviceDetailsViewController
            
            if let name = self.DeviceNamesArray[(indexPath as NSIndexPath).row] as? NSMutableDictionary{
                
                detailsViewController.self.strUserid = name["userid"] as? String as NSString!
            }
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
            
        }
        
        */
       
        
        if self.resultSearchController.isActive
        {
            
            tableView.deselectRow(at: indexPath, animated: true)
            DispatchQueue.main.async {
               // [unowned self] in
                let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "DeviceDetailsViewController") as! DeviceDetailsViewController
                
                if let name = self.filteredDevices[indexPath.row] as? NSMutableDictionary{
  
                    detailsViewController.self.strUserid = name["userid"] as? String as NSString!
                }
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
                
            }
            
        }
        else
        {
            tableView.deselectRow(at: indexPath, animated: true)
            DispatchQueue.main.async {
                //[unowned self] in
                let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "DeviceDetailsViewController") as! DeviceDetailsViewController
                
                if let name = self.DeviceNamesArray[indexPath.row] as? NSMutableDictionary{
                    
                    detailsViewController.self.strUserid = name["userid"] as? String as NSString!
                }
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
                
            }
            
            
        }

        
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        filteredDevices.removeAllObjects()
        
        
        let searchPredicate = NSPredicate(format: "DeviceName contains[cd] %@ OR city contains[cd] %@", searchController.searchBar.text!,searchController.searchBar.text!)
        let array = (DeviceNamesArray as NSArray).filtered(using: searchPredicate)
        for type in array {
            // Do something
            
            filteredDevices .add(type)
        }
        
        
        self.tableView.reloadData()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
} //UITableViewController
