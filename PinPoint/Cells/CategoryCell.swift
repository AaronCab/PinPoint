//
//  CategoryCell.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 4/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = #colorLiteral(red: 0.1910400689, green: 0.2061233521, blue: 0.2311887741, alpha: 1) // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    let categoryCellContainerView: UIView = {
        let categoryView = UIView()
        categoryView.backgroundColor = .clear
        categoryView.layer.cornerRadius = 50
        categoryView.layer.masksToBounds = true
        return categoryView
    }()
    
    let categoryName: UILabel = {
        let catName = UILabel()
        catName.text = "Event Name"
        catName.textColor = .white
        catName.textAlignment = .center
        catName.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        catName.font = UIFont.init(name: "futura", size: 14)
        return catName
    }()
    
    let categoryImage: UIImageView = {
        let catImg = UIImageView()
        catImg.image = UIImage(named: "icons8-health-calendar-100")
        catImg.contentMode = .scaleAspectFill
        catImg.layer.masksToBounds = true
        return catImg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.addSubview(categoryCellContainerView)
        
        categoryCellContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
            
        }
        categoryCellContainerView.addSubview(categoryName)
        
        categoryCellContainerView.addSubview(categoryImage)
        
        categoryName.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.height.equalTo(15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        categoryImage.snp.makeConstraints { (make) in
            make.top.equalTo(categoryName.snp.bottom).offset(7)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(71)
            make.width.equalTo(26)
            make.bottom.equalTo(self.snp.bottom).offset(7)
        }
    }
    
}
