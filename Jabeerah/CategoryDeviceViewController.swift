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

class CategoryDeviceViewController: UITableViewController{

     var DeviceNamesArray: NSMutableArray = []
     var titlestring: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   print(globalImageUrl)
        
         self.navigationItem.title = titlestring
         let ref = FIRDatabase.database().reference().child("UserDevices")

  
        ref.queryOrderedByChild("Category").queryEqualToValue(titlestring)
            .observeEventType(.Value, withBlock: { snapshot in
                
                if let dict = snapshot.value as? NSMutableDictionary{
                    
                    //print("dict======print \(dict)")
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
                            if let metname = dictnew["name"] as? String
                            {
                                mainDict.setObject(metname, forKey: "name")
                                
                            }
                            if let metname = dictnew["phone"] as? String
                            {
                                mainDict.setObject(metname, forKey: "phone")
                                
                            }
                            if let metname = dictnew["city"] as? String
                            {
                                mainDict.setObject(metname, forKey: "city")
                                
                            }
                            if let metname = dictnew["email"] as? String
                            {
                                mainDict.setObject(metname, forKey: "email")
                                
                            }
                        }
                       //print("mainDict========= \(mainDict)")
                        self.DeviceNamesArray.addObject(mainDict)
                    }
                }
                      self.tableView.reloadData()
            })
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

        //

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DeviceNamesArray.count
       
    }
      let storageRef = FIRStorage.storage().reference().child("Devices_Images")
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategotyDeviceCellViewCell

        
        if let name = DeviceNamesArray[indexPath.row] as? NSMutableDictionary {
        cell.configureCellone(name["DeviceName"] as! String , Provider: name["name"] as! String , ProviderCity: name["city"] as! String)
         /*
            let m = name["ImageUrl"]
            storageRef.dataWithMaxSize(10 * 1024 * 1024, completion: { (data, error) in
                dispatch_async(dispatch_get_main_queue()){
                    let postPhoto = UIImage(data: data!)
                    cell.CategoryDeviceImage.image = postPhoto
                }
                
            })
            */
            
        }
        
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let detailsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DeviceDetailsViewController") as! DeviceDetailsViewController
                
                if let name = self.DeviceNamesArray[indexPath.row] as? NSMutableDictionary{
                    
                    detailsViewController.self.strUserid = name["userid"] as? String
                }
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
                
            }
            
            
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
 
    
} //UITableView
