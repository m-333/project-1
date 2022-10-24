//
//  usersCollectionViewCell.swift
//  project-1
//
//  Created by melek türüdi on 14.10.2022.
//

import UIKit

class usersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.layer.borderColor = UIColor.blue.cgColor
        
        
        self.lblUserName.textAlignment = .center
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
        self.imgView.layer.borderWidth = 3
        self.imgView.clipsToBounds = true
    }
   
}
