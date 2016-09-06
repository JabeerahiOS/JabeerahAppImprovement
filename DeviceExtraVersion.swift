//
//  DeviceExtraVersion.swift
//  Jabeerah
//
//  Created by Ruba O on 12/5/1437 AH.
//  Copyright © 1437 Jabeerah. All rights reserved.
//

import UIKit

class DeviceExtraVersion:  UIViewController , UISearchResultsUpdating{
    
    //Variable
    var resultSearchController = UISearchController(searchResultsController: nil)
    var filteredDevice: NSMutableArray = []
    var DeviceNamesArray: NSMutableArray = []
    var titlestring: String!
    
    // first
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titlestring
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        //
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
        
        //
        self.navigationItem.title = titlestring
        
        //FireBase URL - DEvices
        let ref = Firebase(url: "https://businesswallet.firebaseio.com/Users")
        
        ref.queryOrderedByChild("Category").queryEqualToValue(titlestring)
            .observeEventType(.Value, withBlock: { snapshot in
                // Depend on Shaikah Section
                if let dict = snapshot.value as? NSMutableDictionary{
                    //print("dict======print \(dict)")
                    
                    for (key,value) in dict {
                        let mainDict = NSMutableDictionary()
                        mainDict.setObject(key, forKey: "userid")
                        
                        
                        if let dictnew = value as? NSMutableDictionary{
                            
                            if let metname = dictnew["BusinessName"] as? String
                            {
                                mainDict.setObject(metname, forKey: "BusinessName")
                            }
                            if let metname = dictnew["ShortDescription"] as? String
                            {
                                mainDict.setObject(metname, forKey: "ShortDescription")
                            }
                            if let metname = dictnew["Category"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Category")
                            }
                            if let metname = dictnew["City"] as? String
                            {
                                mainDict.setObject(metname, forKey: "City")
                            }
                            if let metname = dictnew["ContactMe"] as? String
                            {
                                mainDict.setObject(metname, forKey: "ContactMe")
                            }
                            if let metname = dictnew["Details"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Details")
                            }
                            if let metname = dictnew["Email"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Email")
                            }
                            if let metname = dictnew["PhoneNumber"] as? String
                            {
                                mainDict.setObject(metname, forKey: "PhoneNumber")
                            }
                            if let metname = dictnew["Provider"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Provider")
                            }
                            if let metname = dictnew["Website1"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Website1")
                            }
                            if let metname = dictnew["Website2"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Website2")
                            }
                        }
                        //print("mainDict========= \(mainDict)")
                        self.DeviceNamesArray.addObject(mainDict)
                        //print("mainDict2========= \(mainDict)")
                    }
                    //print("array is \(self.BusinessNamesArray)")
                }
                self.tableView.reloadData()
                
            })
    }
    
    
    
    
    
    //  Table view data source
    //1
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    //2
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.resultSearchController.active
        {
            return self.filteredDevice.count
        }else
        {
            return DeviceNamesArray.count
        }
    }
    //3
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeviceCell", forIndexPath: indexPath) as UITableViewCell
        
        if self.resultSearchController.active
        {
            if let name = self.filteredDevice[indexPath.row] as? NSMutableDictionary
            {
                // image ,
                cell.textLabel?.text = name["DeviceName"] as? String
                cell.textLabel?.text = name["ProviderName"] as? String
                cell.textLabel?.text = name["Location"] as? String
            }
        }
        else
        {
            
            if let name = DeviceNamesArray[indexPath.row] as? NSMutableDictionary
            {
                // image ,
                cell.textLabel?.text = name["DeviceName"] as? String
                cell.textLabel?.text = name["ProviderName"] as? String
                cell.textLabel?.text = name["Location"] as? String
            }
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    //4
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if self.resultSearchController.active
        {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let detailsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProjectDeviceViewController") as! DeviceViewController
                
                if let name = self.filteredDevice[indexPath.row] as? NSMutableDictionary{
                    
                    
                    detailsViewController.self.strUserid = name["userid"] as? String
                }
                
                self.navigationController?.pushViewController(deviceViewController, animated: true)
                
            }
            
        }
        else
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let DeviceViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProjectDeviceViewController") as! DeviceViewController
                
                if let name = self.DeviceNamesArray[indexPath.row] as? NSMutableDictionary{
                    
                    DeviceViewController.self.strUserid = name["userid"] as? String
                }
                
                self.navigationController?.pushViewController(deviceViewController, animated: true)
                
            }
            
            
        }
    }
    
    //5 ماني متاكدة اذا احنا بنبحث باسم المزود واسم الجهاز
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredDevice.removeAllObjects()
        let searchPredicate = NSPredicate(format: "DeviceName contains[cd] %@ OR ProviderName contains[cd] %@", searchController.searchBar.text!,searchController.searchBar.text!)
        let array = (DeviceNamesArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        for type in array {
            filteredDevice.addObject(type)
        }
        self.tableView.reloadData()
    }
    
}




