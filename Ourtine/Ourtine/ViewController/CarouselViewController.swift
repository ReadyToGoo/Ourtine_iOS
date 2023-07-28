//
//  CarouselViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/07/24.
//

import UIKit

class CarouselViewController: UIViewController {
    private var items = [
        CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card1"),
        CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card2"),
        CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card3"),
        CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card4"),
        CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card5"),
        CarouselItem(image: UIImage(systemName: "heart.fill"), title: "Card6")
    ]
    
    private enum Const {
        static let itemSize = CGSize(width: 108, height: 152)
        static let itemSpacing = 14.9
        
//        static var insetX: CGFloat {
//            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
//        }
        
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        }
    }
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize
        layout.minimumInteritemSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(CardViewCell.self, forCellWithReuseIdentifier: CardViewCell.id)
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = Const.collectionViewContentInset
        view.decelerationRate = .fast
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        setConstraints()
    }
    
    private func setConstraints() {
        self.collectionView.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(Const.itemSize.height)
        }
    }
    
}

extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.id, for: indexPath) as! CardViewCell
        let item = self.items[indexPath.item]
        cell.prepare(image: item.image, text: item.title)
        
        return cell
    }
}

extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

import SwiftUI
struct CarouselViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let ViewController = CarouselViewController()
            return ViewController
        }
    }
}
