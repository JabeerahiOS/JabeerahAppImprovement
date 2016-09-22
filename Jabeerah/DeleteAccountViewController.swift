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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    var globalImageURL : String!
    override func viewWillAppear(_ animated : Bool){
        super.viewWillAppear(animated)
        retrieveUserData{(ImageURL) in
            self.globalImageURL = ImageURL
            
        }
    }
    
    func retrieveUserData(_ completionBlock : @escaping ((_ ImageURL : String?)->Void)){
        ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).observe(.value , with: {snapshot in
            
            if let userDict =  snapshot.value as? [String:AnyObject]  {
                completionBlock(userDict["ImageUrl"] as! String)
            }
        })
    }
    
    @IBAction func DeleteAccountButton(_ sender: AnyObject) {
       
    
         
         FIRAuth.auth()?.currentUser!.delete(completion: ){ error in
         if  error != nil {
         } else {
         print("Account Deleted Sucessfully")
         }
         } //Delete Account Function
         
  

        
        /*
        let user = FIRAuth.auth()?.currentUser
        
        let mainpass = UserDefaults.standard.object (forKey: "password") as? String
        let mainEmail = UserDefaults.standard.object (forKey: "email") as? String

        let credential = FIREmailPasswordAuthProvider.credential(withEmail: mainEmail!, password: mainpass!)
        
        user?.reauthenticate(with: credential) { error in
        if error != nil {
           print(error?.localizedDescription)
            }
        else {
            let storageRef = FIRStorage.storage().reference().child("Devices_Images").child(self.globalImageURL)
            storageRef.delete { (error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    print("Image deleted successfully")
                }
            } //Delete File
            
            FIRDatabase.database().reference().child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).removeValue(completionBlock: error as! (Error?, FIRDatabaseReference) -> Void)
            
            FIRDatabase.database().reference().child("Devices").child(FIRAuth.auth()!.currentUser!.uid).removeValue(completionBlock: error as! (Error?, FIRDatabaseReference) -> Void)
            FIRAuth.auth()?.currentUser!.delete(completion: ){ error in
                if  error != nil {
                } else {
                    print("Account Deleted Sucessfully")
                }
            } //Delete Account Function
        } //re-authenticated else
   } //re-authenticated function
 */
    }//Delete Button

} //DeleteAccountViewController


