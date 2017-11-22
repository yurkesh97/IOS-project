//
//  CircleImageView.swift
//  MyFirstApp
//
//  Created by Mariana Sytnyk on 07.11.17.
//  Copyright © 2017 MS. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.width / 2
    }

}
