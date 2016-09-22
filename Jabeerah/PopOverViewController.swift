

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
//import social

class PopOverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    let ref = FIRDatabase.database().reference()
   
    var imagePicker : UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var CategoryPickerView: UIPickerView!
    var Category = ["عكازات", "عربات متحركة", "أدوات دورات المياه", "أجهزة طبية", "أخرى"]
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var DeviceName: UITextField!
    @IBOutlet weak var Description: UITextField!

    var globalUserName : String!
    var globalEmail : String!
    var globalPhone : String!
    var globalCity : String!
    
    override func viewWillAppear(_ animated : Bool){
        super.viewWillAppear(animated)
        retrieveUserData{(name,email,phone,city) in
            self.globalUserName = name
            self.globalEmail = email
            self.globalPhone = phone
            self.globalCity = city
        }
     
    }
    
    func retrieveUserData(_ completionBlock : @escaping ((_ name : String?,_ email : String?, _ phone : String?, _ city : String?)->Void)){
        ref.child("UserProfile").child(FIRAuth.auth()!.currentUser!.uid).observe(.value , with: {snapshot in
            
            if let userDict =  snapshot.value as? [String:AnyObject]  {
                
                completionBlock(userDict["name"] as! String,userDict["email"] as! String, userDict["phone"] as! String, userDict["city"] as! String)
            }
        })
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        CategoryPickerView.delegate = self
        CategoryPickerView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //To hide keyboard when pressing anything on screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
      
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

       
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var itemSelected = ""
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        itemSelected = Category[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let theInfo:NSDictionary = info as NSDictionary
      //let img:UIImage = theInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageView.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddPictureBtnAction(_ sender: AnyObject) {
        // addPictureBtnAtion.enabled = false
        let alertController : UIAlertController = UIAlertController(title: "أضف جهازًا", message: "التقط صورة من الكاميرا أو اختر من الألبوم", preferredStyle: .actionSheet)
        
        let cameraAction : UIAlertAction = UIAlertAction(title: "صورة من الكاميرا", style: .default, handler: {(cameraAction) in
            print("camera Selected...")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == true {
                
                self.imagePicker.sourceType = .camera
                self.present()
                
            }else{
                self.present(self.showAlert("عذرًا", Message: "الكاميرا ليست متاحة في هذا الجهاز أو تم منع الوصول لها!"), animated: true, completion: nil)
                
            }
            
        })
        
        let libraryAction : UIAlertAction = UIAlertAction(title: "صورة من الألبوم", style: .default, handler: {(libraryAction) in
            
            print("Photo library selected....")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) == true {
                
                self.imagePicker.sourceType = .photoLibrary
                self.present()
                
            }else{
                
                self.present(self.showAlert("عذرًا", Message: "ألبوم الصور ليس متاحًا في هذا الجهاز أو تم منع الوصول له!"), animated: true, completion: nil)
            }
        })
        
        let cancelAction : UIAlertAction = UIAlertAction(title: "إلغاء", style: .cancel , handler: {(cancelActn) in
            print("Cancel action was pressed")
        })
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func present(){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    /*   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     print("info of the pic reached :\(info) ")
     self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
     
     } */
    
    //Show Alert
    func showAlert(_ Title : String!, Message : String!)  -> UIAlertController {
        
        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            print("User pressed ok function")
            
        }
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        return alertController
    }

    
   
    
    @IBAction func AddDeviceButton(_ sender: AnyObject) {
        
        if DeviceName.text == "" || Description.text == "" || ImageView.image == nil {
            let alert = UIAlertController(title: "عذرًا", message:"يجب عليك تعبئة معلومات الجهاز كاملة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
            self.present(alert, animated: true){}
            
        } else {
            
            let imageName = UUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("Devices_Images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(self.ImageView.image!)  {
                storageRef.put(uploadData, metadata: nil, completion: { (data, error) in
                    if error != nil {
                        print(error)
                        
                    } else {
                        print("Image Uploaded Succesfully")
                        let profileImageUrl = data?.downloadURL()?.absoluteString
                        
                       
                        
                        //
                        let DeviceInfo = [
                            "ImageUrl":profileImageUrl!,
                            "DeviceName":self.DeviceName.text!,
                            "Description":self.Description.text!,
                            "Category":self.itemSelected
                        ]
                        let DeviceInformation = [
                            "ImageUrl":profileImageUrl!,
                            "DeviceName":self.DeviceName.text!,
                            "Description":self.Description.text!,
                            "Category":self.itemSelected,
                            "name": self.globalUserName,
                            "email":self.globalEmail ,
                            "city": self.globalCity,
                            "phone": self.globalPhone
                        ]
                        self.ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).observeSingleEvent(of: .value, with: {(snapShot) in
                            if snapShot.exists(){
                                let numberOfDevicesAlreadyInTheDB = snapShot.childrenCount
                                if numberOfDevicesAlreadyInTheDB < 3{
                                    let newDevice = String("Device\(numberOfDevicesAlreadyInTheDB+1)")
                                    let userDeviceRef = self.ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid)
                                    userDeviceRef.observeSingleEvent(of: .value, with: {(userDevices) in
                                        if let userDeviceDict = userDevices.value as? NSMutableDictionary{
                                            
                                            userDeviceDict.setObject(DeviceInfo,forKey: newDevice as! NSCopying)
                                            
                                            userDeviceRef.setValue(userDeviceDict)
                                        }
                                    })
                                }
                                else{
                                    let alert = UIAlertController(title: "عذرًا", message:"يمكنك إضافة ثلاثة أجهزة فقط كحد أقصى", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                                    self.present(alert, animated: true){}
                                }
                            }else{
                                self.ref.child("Devices").child(FIRAuth.auth()!.currentUser!.uid).setValue(["Device1" : DeviceInfo])
                                self.ref.child("UserDevices").childByAutoId().setValue(DeviceInformation)
                                
                                
                                let alert = UIAlertController(title: "ممتاز", message:"تم إضافة الجهاز بنجاح", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "نعم", style: .default) { _ in })
                                self.present(alert, animated: true){}

                              self.navigationController!.popToRootViewController(animated: true)
                            }
                        })
                        
                        //
                    } })
            }
        } //B B Else
    } //AddDeviceButton
 
   /*
    func hideKeyboard() {
    self.view.endEditing(true)
    }
    
    func hideKeyboardWhenBackgroundIsTapped() {
        let tgr = UITapGestureRecognizer(target: self, action:Selector("hideKeyboard"))
        self.view.addGestureRecognizer(tgr)
    }
*/


} // UIView Controlller
