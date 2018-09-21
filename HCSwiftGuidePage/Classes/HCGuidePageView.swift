//
//  HCGuidePageViewController.swift
//  HCSwiftGuidePage
//
//  Created by cgtn on 2018/9/12.
//

import UIKit

public class HCGuidePageView: UIView {

    
    private var imagesArray:[String] = [String]()
    
    private var canSkip: Bool = true
    
    private let pageControl = UIPageControl()
    
    private let skipBtn = UIButton(type: .custom)
    
    private lazy var expreienceBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.cyan
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(HCGuidePageView.skipBtnAction), for: .touchUpInside)
        return btn
    }()
    
    public init(imagesArray:[String],canSkip: Bool = true) {
        let frame = UIScreen.main.bounds
        super.init(frame: frame)
        HCPrint("HCGuidePageView init")
        self.imagesArray = imagesArray
        
        self.canSkip = canSkip
        
        setupCollectionView()
        
        setupSkipBtn()
        
        setupPageControl()
    }
    

    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   private func flowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        return flowLayout
    }
    
   private func setupCollectionView() {
    
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout())
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.register(HCImagesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
   private func setupSkipBtn() {
    
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.backgroundColor = UIColor.white
        skipBtn.setTitleColor(UIColor.orange, for: .normal)
        skipBtn.layer.cornerRadius = 20
        skipBtn.layer.masksToBounds = true
        skipBtn.isHidden = !canSkip
        addSubview(skipBtn)
        
        skipBtn.translatesAutoresizingMaskIntoConstraints = false
        skipBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        skipBtn.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        skipBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        skipBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        skipBtn.addTarget(self, action: #selector(HCGuidePageView.skipBtnAction), for: .touchUpInside)
    }
    
    @objc private func skipBtnAction() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func setupPageControl() {

        pageControl.numberOfPages = imagesArray.count
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    
    public func configureSkipButton(skip: (UIButton)->()) {
        if !canSkip {
            return
        }
        skip(skipBtn)
    }

    public func configureExpreienceButton(expreience: (UIButton)->()) {
        expreience(expreienceBtn)
    }

    deinit {
        
        HCPrint("HCGuidePageViewController----deinit")
        
    }
    
}

extension HCGuidePageView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HCImagesCollectionViewCell
        cell.configureCell(imageName: imagesArray[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == imagesArray.count - 1 {
            DispatchQueue.once(token: "ImmediatelyExpreience") {
                cell.addSubview(self.expreienceBtn)
                
                self.expreienceBtn.translatesAutoresizingMaskIntoConstraints = false
                self.expreienceBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
                self.expreienceBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
                self.expreienceBtn.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
                self.expreienceBtn.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -60).isActive = true
            }
        }
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        HCPrint("scrollViewDidEndScrollingAnimation")
    }
    
}
