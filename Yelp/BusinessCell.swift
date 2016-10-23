//
//  BusinessCell.swift
//  Yelp
//
//  Created by Liang Rui on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking
class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var reviewsNumberLabel: UILabel!
    var business : Business! {
        didSet {
            titleLabel.text = business.name
            thumbView.setImageWith(business.imageURL!)
            
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewsNumberLabel.text = "\(business.reviewCount!) Reviews"
            starsImageView.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbView.layer.cornerRadius = 5
        thumbView.clipsToBounds = true
        //titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
