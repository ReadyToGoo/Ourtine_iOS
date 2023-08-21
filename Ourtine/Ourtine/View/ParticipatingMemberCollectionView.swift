//
//  ParticipatingMemberCollectionViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit
import SnapKit

protocol ParticipatingMemberCollectionViewDelegate: AnyObject {
    func didSelectMember(_ memberData: MemberModel)
}

class ParticipatingMemberCollectionView: UIView {
    
    weak var delegate: ParticipatingMemberCollectionViewDelegate?
    
    private let reuseIdentifier = ParticipatingMemberViewCell.id

    var participantNum = Dummy_participatingMemberList.count

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 138)
        return layout
    }()

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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participantNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ParticipatingMemberViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = delegate
        cell.getMemberData(data: Dummy_participatingMemberList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if participantNum < 5 {
            return 28
        } else {
            return 24
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if participantNum < 5 {
            return 52
        } else {
            return 32
        }
    }
}
