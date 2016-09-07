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
    @IBOutlet weak var DeviceProvider: UILabel!
    @IBOutlet weak var DeviceName: UILabel!
   
    @IBOutlet weak var City: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(Image:UIImage, Provider:String , Device:String, CityName:String)
    {
        CategoryDeviceImage.image = Image
        DeviceProvider.text = Provider
        DeviceName.text = Device
        City.text = CityName
        
    }


}
