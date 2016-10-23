//
//  SwitchCell.swift
//  Yelp
//
//  Created by Liang Rui on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    weak var delegate : SwitchCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onSwitch.addTarget(self, action: "switchChanged", for: UIControlEvents.valueChanged)
        
    }
    
    func switchChanged () {
        print ("Switch value changed")
            delegate?.switchCell?(switchCell: self, didChangeValue: self.onSwitch.isOn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
