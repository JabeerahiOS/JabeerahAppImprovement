//
//  DeviceDetailsViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/7/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class DeviceDetailsViewController: UIViewController {

    var strUserid : NSString!
    
    @IBOutlet weak var DeviceDetailsImageView: UIImageView!
    @IBOutlet weak var DeviceDetailsProvider: UILabel!
    @IBOutlet weak var DeviceDetailsName: UILabel!
    @IBOutlet weak var DeviceDetailsDescription: UILabel!
    @IBOutlet weak var DeviceDetailsCity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("idis \(self.strUserid)")
        
         let ref = FIRDatabase.database().reference().child("UserDevices")
       
        
        ref.childByAppendingPath(self.strUserid as String).observeEventType(.Value, withBlock: { snapshot in
            
            if let dict = snapshot.value as? NSMutableDictionary{
                
                print("dict is \(dict)")
                
                
                
                if let Provider = dict["name"] as? String
                {
                    self.DeviceDetailsProvider.text = Provider
                    self.navigationItem.title = Provider
                }
                if let name = dict["DeviceName"] as? String
                {
                    self.DeviceDetailsName.text = name
                    self.navigationItem.title = name
                }
                if let ShortDescription = dict["Description"] as? String
                {
                    self.DeviceDetailsDescription.text = ShortDescription
                }
                if let City = dict["city"] as? String
                {
                    self.DeviceDetailsCity.text = City
                }
            }
        })
        
        
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PhoneCallButton(sender: AnyObject) {
    }
    
    @IBAction func WhatsAppButton(sender: AnyObject) {
    }
    
    @IBAction func EmailButton(sender: AnyObject) {
    }
    
    @IBAction func MsgButton(sender: AnyObject) {
    }

 

}
