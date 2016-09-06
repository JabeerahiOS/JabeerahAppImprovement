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
    @IBOutlet weak var FavScrollView: UIScrollView!
    var ImageArray = [UIImage]()
    @IBOutlet weak var NameLB: UILabel!
    @IBOutlet weak var EmailLB: UILabel!
    @IBOutlet weak var PhoneLB: UILabel!
    @IBOutlet weak var CityLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieving User Information
        let ref = FIRDatabase.database().reference()
        ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).observeEventType(.Value , withBlock: {snapshot in
            self.NameLB.text   =  snapshot.value!.objectForKey("name")     as? String
            self.EmailLB.text  =  snapshot.value!.objectForKey("email")    as? String
            self.PhoneLB.text  =  snapshot.value!.objectForKey("phone")    as? String
            self.CityLB.text   =  snapshot.value!.objectForKey("city")     as? String
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LOGOUT(sender: AnyObject) {
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
            self.navigationController!.popToRootViewControllerAnimated(true)

        }    }
    
    
    }

   
