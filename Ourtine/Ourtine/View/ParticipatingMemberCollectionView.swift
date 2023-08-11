//
//  ParticipatingMemberCollectionViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit

private let reuseIdentifier = ParticipatingMemberViewCell.id

class ParticipatingMemberCollectionView: UICollectionViewController {
    var participantNum = Dummy_participatingMemberList.count

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 52
        flowLayout.minimumLineSpacing = 24
//        if participantNum < 5 {
//            flowLayout.itemSize = CGSize(width: 272, height: 300)
//        } else {
//            flowLayout.itemSize = CGSize(width: 328, height: 256)
//        }
        
        collectionView.backgroundColor = .clear
        collectionView.register(ParticipatingMemberViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // Num of Cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participantNum
    }

    // Cell Content
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ParticipatingMemberViewCell else {
            return UICollectionViewCell()
        }

        // Configure the cell
        cell.getMemberData(data: Dummy_participatingMemberList[indexPath.row])

        return cell
    }
    
    // Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Double
        let height: Double

        if participantNum < 5 {
            width = 110
            height = 138
        } else {
            width = 88
            height = 114
        }

        return CGSize(width: width, height: height)
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
