//
//  CategoryCellExtraVersion.swift
//  Jabeerah
//
//  Created by Ruba O on 12/5/1437 AH.
//  Copyright © 1437 Jabeerah. All rights reserved.
//

import UIKit

class CategoryCellExtraVersion: UITableViewCell {
    
    @IBOutlet weak var CategoryPhoto: UIImageView!
    @IBOutlet weak var CategoryType: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(Image:UIImage, Title:String , Description:String)
    {
        CategoryPhoto.image = Image
        CategoryType.text = Title
    }
    
    
}

