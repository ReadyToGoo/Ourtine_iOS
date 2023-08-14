//
//  ParticipatingMemberCollectionViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit
import SnapKit

class ParticipatingMemberCollectionView: UIView {

    private let reuseIdentifier = ParticipatingMemberViewCell.id

    var participantNum = Dummy_participatingMemberList.count

    // layout
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 138)
        return layout
    }()

    // collectionView
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(ParticipatingMemberViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.backgroundColor = .red
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(300)
                make.width.equalToSuperview()
            }
    }


}

extension ParticipatingMemberCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    // numOfCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participantNum
    }
    
    // cellContent
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ParticipatingMemberViewCell else {
            return UICollectionViewCell()
        }
        cell.getMemberData(data: Dummy_participatingMemberList[indexPath.row])
        
        return cell
    }
    
    // Top-Bottom Distance Between Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if participantNum < 5 {
            return 28
        } else {
            return 24
        }
    }

    // Left-Right Distance Between Cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if participantNum < 5 {
            return 52
        } else {
            return 32
        }
    }
    
}
