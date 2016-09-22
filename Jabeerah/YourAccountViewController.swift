//
//  YourAccountViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/29/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class YourAccountViewController: UIViewController {


    @IBOutlet weak var DeviceScrollView: UIScrollView!
    var DeviceArray = [UIImage]()
    @IBOutlet weak var NameLB: UILabel!
    @IBOutlet weak var EmailLB: UILabel!
    @IBOutlet weak var PhoneLB: UILabel!
    @IBOutlet weak var CityLB: UILabel!
    
   
    @IBOutlet weak var ImageViewOne: UIImageView!
    @IBOutlet weak var ImageViewTwo: UIImageView!
    @IBOutlet weak var ImageViewThree: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieving User Information
        let ref = FIRDatabase.database().reference()
        ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).observe(.value , with: {snapshot in
            self.NameLB.text   =  (snapshot.value! as AnyObject).object(forKey: "name")     as? String
            self.EmailLB.text  =  (snapshot.value! as AnyObject).object(forKey: "email")    as? String
            self.PhoneLB.text  =  (snapshot.value! as AnyObject).object(forKey: "phone")    as? String
            self.CityLB.text   =  (snapshot.value! as AnyObject).object(forKey: "city")     as? String
        })
   
       
        //Retrieving User Device Image
    if ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).child("Device1") != nil  {
    ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).child("Device1").observe(.value , with: {snapshot in
        if let deviceDict = snapshot.value! as? [String : AnyObject]{
            let imageUrl = deviceDict["ImageUrl"] as! String
            self.ImageViewOne.downloadedFrom(link: imageUrl)
        }
        
        })
        
    } else {
        //
        }

    if ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).child("Device2") != nil {
            
            ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).child("Device2").observe(.value , with: {snapshot in
                if let deviceDict = snapshot.value! as? [String : AnyObject]{
                    let imageUrl = deviceDict["ImageUrl"] as! String
                    self.ImageViewTwo.downloadedFrom(link: imageUrl)
                }            })
            
        } else {
            //
        }
        
    if ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).child("Device3") != nil  {
            
            ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).child("Device3").observe(.value , with: {snapshot in
                if let deviceDict = snapshot.value! as? [String : AnyObject]{
                    let imageUrl = deviceDict["ImageUrl"] as! String
                    self.ImageViewThree.downloadedFrom(link: imageUrl)
                }
            })
            
        } else {
            //
        }

    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LOGOUT(_ sender: AnyObject) {
        if let user = FIRAuth.auth()?.currentUser {
            print("User is signed in.")
        } else {
            print("No user is signed in.")
        }
        if FIRAuth.auth()?.currentUser != nil {
            do {
                print("Trying to signout user")
                try FIRAuth.auth()?.signOut()
                print("Sucess")
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        if let user = FIRAuth.auth()?.currentUser {
            print("User still signed in.")
        } else {
            print("Now the user is not signed in.")
            self.navigationController!.popToRootViewController(animated: true)

        }    }
    
    
    }

   
