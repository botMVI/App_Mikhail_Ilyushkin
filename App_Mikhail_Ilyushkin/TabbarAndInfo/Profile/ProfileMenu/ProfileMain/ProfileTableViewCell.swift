//
//  ProfileTableViewCell.swift
//  App_Mikhail_Ilyushkin
//
//  Created by Michael Iliouchkin on 23.09.2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    
        override func layoutSubviews() {
            super.layoutSubviews()
            
            textLabel?.frame = CGRect(x: 70, y: textLabel!.frame.origin.y, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        }

    
}

