//
//  CategoryCell.swift
//  NewJabeerah
//
//  Created by Ruba O on 11/29/1437 AH.
//  Copyright © 1437 Ruba O. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell
{

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

