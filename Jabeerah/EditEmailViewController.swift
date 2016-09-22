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

      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func EditEmailButton(_ sender: AnyObject) {
        
        if NewEmailTF.text == "" {
        
            let alert = UIAlertController(title: "عذرًا", message:"أدخل الإيميل من فضلك", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}

        
        } else {
            
            FIRAuth.auth()!.currentUser!.updateEmail(NewEmailTF.text!) { error in
                
                if  error != nil {
                    
                    switch FIRAuthErrorCode(rawValue:error!._code)! {
                    case .errorCodeInvalidEmail:
                        let alert = UIAlertController(title: "عذرًا", message:"الإيميل غير صحيح", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    case .errorCodeEmailAlreadyInUse:
                        let alert = UIAlertController(title: "عذرًا", message:"الإيميل مستخدم", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    case .errorCodeNetworkError:
                        let alert = UIAlertController(title: "عذرًا", message:"خطأ في الشبكة", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    default:
                        let alert = UIAlertController(title: "عذرًا", message:"خطأ غير معروف", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                        self.present(alert, animated: true){}
                        
                    }
                    
                    
                } else {
                    
                    print("Email Updated Successfully!")
                    self.ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues([
                        "email" : self.NewEmailTF.text!
                        ])
                    self.performSegue(withIdentifier: "EditEmail", sender: nil)
                    
                    
                }

        
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
