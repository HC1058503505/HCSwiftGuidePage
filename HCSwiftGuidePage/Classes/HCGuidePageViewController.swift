//
//  HCGuidePageViewController.swift
//  HCSwiftGuidePage
//
//  Created by cgtn on 2018/9/12.
//

import UIKit

public class HCGuidePageViewController: UIViewController {
    
    private var customLayout:UICollectionViewLayout = UICollectionViewFlowLayout()
    
    private var imagesArray:[String] = [String]()
    
    private var canSkip: Bool = true
    
    private let pageControl = UIPageControl()
    
    public var skipAction: (() -> ())?
    
    public init(imagesArray:[String]?, customLayout:UICollectionViewLayout?, canSkip: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        
        self.imagesArray = imagesArray ?? [String]()
        
        self.customLayout = customLayout ?? flowLayout()
        
        self.canSkip = canSkip
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.cyan
        
        
        
        setupCollectionView()
        
        setupSkipBtn()
        
        setupPageControl()
        
        
    }
    
   private func flowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        return flowLayout
    }
    
   private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout)
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(HCImagesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
   private func setupSkipBtn() {
        let skipBtn = UIButton(type: .custom)
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.backgroundColor = UIColor.white
        skipBtn.setTitleColor(UIColor.orange, for: .normal)
        skipBtn.layer.cornerRadius = 20
        skipBtn.layer.masksToBounds = true
        skipBtn.isHidden = !canSkip
        view.addSubview(skipBtn)
        
        skipBtn.translatesAutoresizingMaskIntoConstraints = false
        skipBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        skipBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        skipBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        skipBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        skipBtn.addTarget(self, action: #selector(HCGuidePageViewController.skipBtnAction), for: .touchUpInside)
    }
    
    @objc private func skipBtnAction() {
        if let skip = skipAction {
            skip()
        }
    }
    
    private func setupPageControl() {

        pageControl.numberOfPages = imagesArray.count
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    deinit {
        print("HCGuidePageViewController----deinit")
    }
    
}

extension HCGuidePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HCImagesCollectionViewCell
        cell.configureCell(imageName: imagesArray[indexPath.row])
        cell.goAction = {
            self.skipBtnAction()
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! HCImagesCollectionViewCell).goBtnIsHidden(isHidden: indexPath.row != imagesArray.count - 1)

    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
}
