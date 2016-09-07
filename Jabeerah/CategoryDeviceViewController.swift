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
     var titlestring: String!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = titlestring
 
        let ref = FIRDatabase.database().reference().child("Devices").child(FIRAuth.auth()!.currentUser!.uid)

        ref.queryOrderedByChild("Category").queryEqualToValue(titlestring)
            .observeEventType(.Value, withBlock: { snapshot in
                
                if let dict = snapshot.value as? NSMutableDictionary{
                    //print("dict======print \(dict)")
                    
                    for (key,value) in dict {
                        let mainDict = NSMutableDictionary()
                        mainDict.setObject(key, forKey: "userid")
                        
                        
                        if let dictnew = value as? NSMutableDictionary{
                            
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
                        //print("mainDict========= \(mainDict)")
                        self.DeviceNamesArray.addObject(mainDict)
                        //print("mainDict2========= \(mainDict)")
                    }
                    //print("array is \(self.BusinessNamesArray)")
                }
                self.tableView.reloadData()
                
            })
        
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DeviceNamesArray.count
       
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if let name = DeviceNamesArray[indexPath.row] as? NSMutableDictionary {
            
            cell.textLabel?.text = name["DeviceName"] as? String
            cell.detailTextLabel?.text = name["Description"] as? String
        }
     //   cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
