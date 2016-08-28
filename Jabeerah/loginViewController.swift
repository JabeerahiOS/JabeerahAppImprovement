

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class loginViewController: UIViewController {
    
    @IBOutlet weak var UserEmail: UITextField!
    
    @IBOutlet weak var UserPassword: UITextField!
    
    
    @IBAction func SignIn(sender: UIButton) {
        guard let Email = UserEmail.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) where !Email.isEmpty else{
            
            print("Email is Empty")
            
            let alert = UIAlertController(title: "Email is Empty", message: "الرجاء كتابة البريد الإلكتروني", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction)in
                
                self.UserEmail.becomeFirstResponder()
                
                }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
                
        guard let Password = UserPassword.text where !Password.isEmpty else {
            
            print("Password is Empty")
            
            let alert = UIAlertController(title: "Password is Empty", message: "االرجاء إدخال كلمة المرور ", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction)in
                
                self.UserPassword.becomeFirstResponder()
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
            
        }
        self.view.endEditing(true)
        FIRAuth.auth()?.signInWithEmail(Email, password: Password, completion: { (user: FIRUser? ,error: NSError?) in
         
            //check password here
            
            if let error = error {
                print(error)
                
                if error.code == 17011 {
                    let alert = UIAlertController (title: " user not found", message: " المستخدم غير موجود ", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction)in
                        
                        self.UserEmail.becomeFirstResponder()
                        
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }else {
                    if error.code == 17009 {
                        
                        let alert = UIAlertController (title: "invalid password ", message: " كلمة المرور غير صحيحة", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction)in
                            
                            self.UserPassword.becomeFirstResponder()
                            
                        }))
                     //   self.presentViewController(alert, animated: true, completion: nil)
                        
                        // the password is invalid
                    }
                }
                
            }else{
                if user != nil {
                    print("user")
                     self.performSegueWithIdentifier("SignIn", sender: nil)
             //    let sb = UIStoryboard(name: "Main", bundle: nil)
              //      let vc = sb.instantiateViewControllerWithIdentifier("Home")
             //       self.presentedViewController(vc, animated: true, completion: nil)
                    
                } // هذي نعدلها بعدين بحيث اول مايسوي لوق ان يوديه مباشره للديفايز تاب
            }
        })

        

        
    }// end of signin
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    let ref = FIRDatabase.database().reference()
    override func viewDidAppear(animated: Bool) {
        
        if FIRAuth.auth()?.currentUser != nil
        {
            print("there is a user already signed in")
            self.performSegueWithIdentifier("SignIn", sender: self)
        }
        else
        {
            print("You have to login or sign up")
        }

    }


    */
    

}//

