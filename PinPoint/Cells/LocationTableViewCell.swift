//
//  LocationTableViewCell.swift
//  PinPoint
//
//  Created by Jason on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "LocationCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
