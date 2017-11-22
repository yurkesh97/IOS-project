//
//  RoundedButtonView.swift
//  MyFirstApp
//
//  Created by Mariana Sytnyk on 09.11.17.
//  Copyright © 2017 MS. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButtonView: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = cornerRadius
        updateUI()
    }
    
    func updateUI() {
        self.layer.cornerRadius =  cornerRadius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }

}
