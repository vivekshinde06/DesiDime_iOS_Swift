//
//  IntroViewController.swift
//  Desidime_V_1.0
//
//  Created by PCPL 41 on 3/29/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var introCollection: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var page: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        introCollection.reloadData()
        pageControl.hidesForSinglePage = true
    }
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "introcell", for: indexPath) as! IntroCollectionViewCell
        
        cell.imgIntro.image = UIImage(named: "Inro \(Int(indexPath.row) + 1)")
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // MARK: -
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let iOSDeviceScreenSize: CGSize = UIScreen.main.bounds.size
        return CGSize(width: CGFloat(iOSDeviceScreenSize.width), height: CGFloat(iOSDeviceScreenSize.height))
    }
    
    // MARK: - ClickPageControl Method
    
    
    @IBAction func clickPageControl(_ sender: Any) {
        
        let chatStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        
        if let vc = chatStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(_ sender: UIScrollView) {
        
        let pageWidth: CGFloat = introCollection.frame.size.width
        page = Int(floor((introCollection.contentOffset.x - pageWidth / 2) / pageWidth) + 1.0)
        pageControl.currentPage = page
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

