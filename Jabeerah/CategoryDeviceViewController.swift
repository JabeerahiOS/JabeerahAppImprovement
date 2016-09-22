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
        return DeviceNamesArray.count
        
    }
    let storageRef = FIRStorage.storage().reference().child("Devices_Images")
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategotyDeviceCellViewCell
        
      
        if let name = DeviceNamesArray[(indexPath as NSIndexPath).row] as? NSMutableDictionary {
            cell.configureCellone(name["DeviceName"] as! String , Provider: name["name"] as! String , ProviderCity: name["city"] as! String )
            
            //It takes so much to download
            cell.CategoryDeviceImage.downloadedFrom(link: name["ImageUrl"] as! String)
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async { [unowned self] in
            let detailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "DeviceDetailsViewController") as! DeviceDetailsViewController
            
            if let name = self.DeviceNamesArray[(indexPath as NSIndexPath).row] as? NSMutableDictionary{
                
                detailsViewController.self.strUserid = name["userid"] as? String as NSString!
            }
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
} //UITableViewController
