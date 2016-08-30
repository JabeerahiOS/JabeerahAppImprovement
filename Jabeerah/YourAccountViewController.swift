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
import FirebaseStorage

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
        
        let database = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference()
        let tempImageRef = storage.child("tmpDir/tempImage.jbg")
        
        
        /*
 
 let metadata = FIRStorageMeatData()
 metadata.contantType = " Imageview/jpeg "
 
 tempImageRef.putdata(UIImageJPEGRepresentation(Imageview!, 0.8)!, NSDate, metadata: metadata){
 (data,error) in
 if error == nil{
 print("upload success")
 }else{
 print(error?.localizedDescription)
 }
 }
 */
 
        tempImageRef.datawithMaxSize(1*1000*1000){(data,error) in
            if error == nil{
                print(data)
            }else{
                print(error?.localizedDescription)
            }
        }

            
        DeviceScrollView.frame = view.frame
        DeviceArray = [ ]
        for i in 0..<ImageArray.count {
 
            let Imageview = UIImageView()
            Imageview.image = DeviceArray[i]
            Imageview.contentMode = .ScaleAspectFill
            let xPosition = self.view.frame.width * CGFloat(i)
            Imageview.frame = CGRect(x: xPosition, y: 0, width: self.DeviceScrollView.frame.width, height: self.DeviceScrollView.frame.height)
            
            
            DeviceScrollView.contentSize.width = DeviceScrollView.frame.width * CGFloat(i + 1)
            DeviceScrollView.addSubview(Imageview)
            
        }
        FavScrollView.frame = view.frame
        ImageArray = [    ]
        for i in 0..<ImageArray.count {
            
            let Imageview = UIImageView()
            Imageview.image = ImageArray[i]
            Imageview.contentMode = .ScaleAspectFill
            let xPosition = self.view.frame.width * CGFloat(i)
            Imageview.frame = CGRect(x: xPosition, y: 0, width: self.FavScrollView.frame.width, height: self.FavScrollView.frame.height)
            
            
            FavScrollView.contentSize.width = FavScrollView.frame.width * CGFloat(i + 1)
            FavScrollView.addSubview(Imageview)
        }
        
        
        
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
    
    @IBAction func LogOut(sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                print("Sucess")
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
            self.navigationController?.popToRootViewControllerAnimated (true)
        }

    }
    
    

   }
