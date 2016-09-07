//
//  DeleteAccountViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/29/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DeleteAccountViewController: UIViewController {

    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func DeleteAccountButton(sender: AnyObject) {
        
        
        //For Deleting Email and Password!
        FIRAuth.auth()?.currentUser!.deleteWithCompletion { error in
            if  error != nil {
                
                
            } else {
                print("Account Deleted Successfully")
                
                //Delete Photos from Storage
                //This is not the final! Only for testing
                let m = self.ref.child(FIRAuth.auth()!.currentUser!.uid).child("ImageUrl") as! String
                let storageRef = FIRStorage.storage().reference().child("Devices_Images").child(m)
                // Delete the file
                storageRef.deleteWithCompletion { (error) -> Void in
                    if (error != nil) {
                        // Uh-oh, an error occurred!
                    } else {
                        print("Image deleted successfully")
                    }
                }
                
                //Delete Data from Dashboard
                
                
                
            }
        }
        

        
    }
    //Still Working on this part!
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
