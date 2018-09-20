//
//  HCImagesCollectionViewCell.swift
//  HCSwiftGuidePage
//
//  Created by cgtn on 2018/9/12.
//

import UIKit

class HCImagesCollectionViewCell: UICollectionViewCell {
    
    var goAction:(()->())?
    
    private let imageV = UIImageView()
    private let goBtn  = UIButton(type: .custom)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(imageV)
        
        
        goBtn.layer.cornerRadius = 20.0
        goBtn.layer.masksToBounds = true
        goBtn.backgroundColor = UIColor.orange
        goBtn.setTitle("立即体验", for: .normal)
        goBtn.addTarget(self, action: #selector(HCImagesCollectionViewCell.goBtnAction), for: .touchUpInside)
        addSubview(goBtn)
        
        goBtn.translatesAutoresizingMaskIntoConstraints = false
        goBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60).isActive = true
        goBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        goBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
        goBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc private func goBtnAction(){
        guard let go = goAction else { return }
        go()
    }
    
    func configureCell(imageName:String) {
        imageV.image = UIImage(named: imageName)
    }
    
    func goBtnIsHidden(isHidden: Bool) {
        goBtn.isHidden = isHidden
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageV.frame = bounds
    }
}
