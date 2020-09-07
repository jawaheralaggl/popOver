//
//  ViewController.swift
//  popOver
//
//  Created by Jawaher Alagel on 9/5/20.
//  Copyright © 2020 Jawaher Alaggl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageCollection: [UIImage] = [#imageLiteral(resourceName: "dish"), #imageLiteral(resourceName: "shopping-bag"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "dish"), #imageLiteral(resourceName: "popcorn"), #imageLiteral(resourceName: "car")]
    let textCollection: [String] = ["food", "shopping", "car", "cinema", "food", "shopping"]
    var currentX: CGFloat = 0.0
    
    @IBOutlet var popOver: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var pageView: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "#191F2B")
        collectionView.backgroundColor = UIColor(hex: "#191F2B")
        popOver.backgroundColor = UIColor(hex: "#191F2B")
        
        collectionView.layer.cornerRadius = 10
        popButton.layer.cornerRadius = 5
        overrideUserInterfaceStyle = .light
        self.popOver.layer.cornerRadius = 10
        
        let layout = UICollectionViewFlowLayout()
        // layout.itemSize = CGSize(width: 300, height: 150)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(iconsCell.nib(), forCellWithReuseIdentifier: iconsCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageView.numberOfPages = imageCollection.count - 4
        pageView.currentPage = 0
        pageView.currentPageIndicatorTintColor = .black
        pageView.pageIndicatorTintColor = .lightGray
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(Tapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func Tapped() {
        self.popOver.removeFromSuperview()
        view.removeBlur()
    }
    
    
    
    @IBAction func popAction(_ sender: Any) {
        self.view.blurView(style:.systemChromeMaterialDark)
        self.view.addSubview(self.popOver)
        self.popOver.center = self.view.center
        
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if currentX > scrollView.contentOffset.x {
            let pageToJump = floor((currentX - scrollView.contentOffset.x) / collectionView.frame.width)
            if pageToJump == 0 {return}
            else {
                currentX -= pageToJump * collectionView.frame.width
            }
            
            let dif = pageView.currentPage - Int(pageToJump)
            if dif > 0 {
                pageView.currentPage = dif
            }else if dif < 0 {
                pageView.currentPage = imageCollection.count + dif
            }else {
                pageView.currentPage = 0
            }
        }else if currentX < scrollView.contentOffset.x {
            let pageToJump = floor((scrollView.contentOffset.x - currentX) / collectionView.frame.width)
            if pageToJump == 0 {return}
            else {
                currentX += pageToJump * collectionView.frame.width
            }
            pageView.currentPage = (pageView.currentPage + Int(pageToJump)) % imageCollection.count
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
        print("tapped")
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: iconsCell.identifier, for: indexPath) as! iconsCell
        
        cell.configure(with: imageCollection[indexPath.row], text: textCollection[indexPath.row])
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 3) // 15 because of paddings
        print("cell width : \(width)")
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
    
}



