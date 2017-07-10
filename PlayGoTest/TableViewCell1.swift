//
//  TableViewCell1.swift
//  PlayGoTest
//
//  Created by Rob Mellor on 05/07/2017.
//  Copyright © 2017 Red & Yellow. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}

class TableViewCell1: UITableViewCell {
    @IBOutlet weak var eventLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundCardView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.gray.cgColor
        backgroundCardView.layer.shadowOpacity = 100
        backgroundCardView.layer.shadowOffset = CGSize.zero
        backgroundCardView.layer.shadowRadius = 2
        
        venueImage.setRounded()
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
