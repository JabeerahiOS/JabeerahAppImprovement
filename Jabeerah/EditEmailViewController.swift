//
//  EditEmailViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/29/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditEmailViewController: UIViewController {

    @IBOutlet weak var NewEmailTF: UITextField!
    
     let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func EditEmailButton(sender: AnyObject) {
        
        FIRAuth.auth()!.currentUser!.updateEmail(NewEmailTF.text!) { error in
            
            if  error != nil {
                
                switch FIRAuthErrorCode(rawValue:error!.code)! {
                case .ErrorCodeInvalidEmail:
                    let alert = UIAlertController(title: "عذرًا", message:"الإيميل غير صحيح", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    
                case .ErrorCodeEmailAlreadyInUse:
                    let alert = UIAlertController(title: "عذرًا", message:"الإيميل مستخدم", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    
                case .ErrorCodeNetworkError:
                    let alert = UIAlertController(title: "عذرًا", message:"خطأ في الشبكة", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    
                default:
                    let alert = UIAlertController(title: "عذرًا", message:"خطأ غير معروف", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "نعم", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                  
                }

               
            } else {
               
                print("Email Updated Successfully!")
                self.ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues([
                    "email" : self.NewEmailTF.text!
                    ])
                self.performSegueWithIdentifier("EditEmail", sender: nil)
                
                
            }
        }
       
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
