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

    
    // var DeviceNamesArray: NSMutableArray = []
    // var titlestring: String!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //   self.navigationItem.title = titlestring
 
        let ref = FIRDatabase.database().reference().child("Devices").child(FIRAuth.auth()!.currentUser!.uid)

        
       // The way will be changed! Completely!
        
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 10
       
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
     //   if let name = DeviceNamesArray[indexPath.row] as? NSMutableDictionary {
            
           // cell.textLabel?.text = name["DeviceName"] as? String
          //  cell.detailTextLabel?.text = name["Description"] as? String
    }
     //   cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
     //   return cell
   
    */
    


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

