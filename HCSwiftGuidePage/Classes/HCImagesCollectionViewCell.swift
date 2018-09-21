//
//  HCImagesCollectionViewCell.swift
//  HCSwiftGuidePage
//
//  Created by cgtn on 2018/9/12.
//

import UIKit

class HCImagesCollectionViewCell: UICollectionViewCell {
    private let imageV = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(imageV)
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageV.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageV.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func configureCell(imageName:String) {
        imageV.image = UIImage(named: imageName)
    }
}
