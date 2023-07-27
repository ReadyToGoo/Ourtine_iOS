//
//  CarouselViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/07/24.
//

import UIKit

class CarouselViewController: UIViewController {
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
        view.register(CardCell.self, forCellWithReuseIdentifier: CardCell.id)
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = Const.collectionViewContentInset
        view.decelerationRate = .fast
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var items = [UIColor(.blue), UIColor(.brown), UIColor(.gray), UIColor(.green)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: Const.itemSize.height),
            self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
}

extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.id, for: indexPath) as! CardCell
        cell.prepare(color: self.items[indexPath.item])
        
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

final class CardCell: UICollectionViewCell {
    static let id = "CardCell"
    
    private var myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.myView)
        
        self.myView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(color: nil)
    }
    
    func prepare(color: UIColor?) {
        self.myView.backgroundColor = color
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
