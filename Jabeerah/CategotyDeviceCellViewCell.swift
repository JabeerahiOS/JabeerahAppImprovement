//
//  CategotyDeviceCellViewCell.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/6/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit

class CategotyDeviceCellViewCell: UITableViewCell {
    
    @IBOutlet weak var CategoryDeviceImage: UIImageView!
    @IBOutlet weak var DeviceName: UILabel!
    @IBOutlet weak var DeviceProvider: UILabel!
    @IBOutlet weak var City: UILabel!
 
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//, DeviceImage: UIImage
    func configureCellone(DviceName:String, Provider:String, ProviderCity:String)
    {
         //CategoryDeviceImage.image = DeviceImage
         DeviceName.text = DviceName
         DeviceProvider.text = Provider
         City.text = ProviderCity
       //  CategoryDeviceImage.image = DeviceImage
     
    }
    
 
}
