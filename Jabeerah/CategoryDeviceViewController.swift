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

class CategoryDeviceViewController: UITableViewController{

    
     var DeviceNamesArray: NSMutableArray = []
     var ProfileNames: NSMutableArray = []
     var titlestring: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = titlestring

        let ref = FIRDatabase.database().reference().child("Devices")

        ref.queryOrderedByChild("Category").queryEqualToValue(titlestring)
            .observeEventType(.Value, withBlock: { snapshot in
                
                if let dict = snapshot.value as? NSMutableDictionary{
                   
                    
                    for (key,value) in dict {
                        let mainDict = NSMutableDictionary()
                        mainDict.setObject(key, forKey: "userid")
                        
                        
                        if let dictnew = value as? NSMutableDictionary {
                            
                            if let metname = dictnew["DeviceName"] as? String
                            {
                                mainDict.setObject(metname, forKey: "DeviceName")
                            }
                            if let metname = dictnew["Description"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Description")
                            }
                            if let metname = dictnew["Category"] as? String
                            {
                                mainDict.setObject(metname, forKey: "Category")
                            }
                            if let metname = dictnew["ImageUrl"] as? String
                            {
                                mainDict.setObject(metname, forKey: "ImageUrl")
                            }
                        }
                
                        self.DeviceNamesArray.addObject(mainDict)
                      
                    }
                  
                }
                
                
                let refer = FIRDatabase.database().reference().child("UserProfile")
                
                refer.queryOrderedByChild("Category").observeEventType(.Value, withBlock: { snapshot in
                    
                    if let dict = snapshot.value as? NSMutableDictionary{
                        
                        
                        for (key,value) in dict {
                            let mainDict = NSMutableDictionary()
                            mainDict.setObject(key, forKey: "userid")
                            
                            
                            if let dictnew = value as? NSMutableDictionary {
                                
                                if let metname = dictnew["name"] as? String
                                {
                                    mainDict.setObject(metname, forKey: "name")
                                }
                                if let metname = dictnew["city"] as? String
                                {
                                    mainDict.setObject(metname, forKey: "city")
                                }
                                if let metname = dictnew["phone"] as? String
                                {
                                    mainDict.setObject(metname, forKey: "phone")
                                }
                            }
                            
                            self.ProfileNames.addObject(mainDict)
                            
                        }
                        
                    }
                    
                    
                    
                })
                
              self.tableView.reloadData()
                
            })
        

  

        // self.tableView.reloadData()
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DeviceNamesArray.count
       
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategotyDeviceCellViewCell

        
        if let name = DeviceNamesArray[indexPath.row] as? NSMutableDictionary {
        cell.configureCellone((name["DeviceName"] as? String)!)
        }
        if let provider = ProfileNames[indexPath.row]as? NSMutableDictionary {
        cell.configureCellTwo((provider["name"] as? String)!)
        }
        
        return cell
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    



}
