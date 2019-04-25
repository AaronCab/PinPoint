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
    
    let categoryCellContainerView: UIView = {
        let categoryView = UIView()
        categoryView.backgroundColor = .clear
        categoryView.layer.cornerRadius = 10
        categoryView.layer.masksToBounds = true
        return categoryView
    }()
    
    let categoryName: UILabel = {
        let catName = UILabel()
        catName.text = "Event Name"
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
