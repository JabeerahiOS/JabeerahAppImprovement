//
//  EditAccountInfoViewController.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 8/29/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditAccountInfoViewController: UIViewController {

    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var CityTF: UITextField!
    
     let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).observe(.value , with: {snapshot in
            self.NameTF.text   =  (snapshot.value! as AnyObject).object(forKey: "name")     as? String
            self.PhoneTF.text  =  (snapshot.value! as AnyObject).object(forKey: "phone")    as? String
            self.CityTF.text   =  (snapshot.value! as AnyObject).object(forKey: "city")     as? String
        })
        
        //To hide keyboard when pressing anything on screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
       //Calls this function when the tap is recognized.
         func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    } //viewDidLoad
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EditInfoButton(_ sender: AnyObject) {
        
        self.ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues([
            "name" : self.NameTF.text!,
            "phone": self.PhoneTF.text!,
            "city" : self.CityTF.text!,
            ])
       self.performSegue(withIdentifier: "EditAccountInfo", sender: nil)
        
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
