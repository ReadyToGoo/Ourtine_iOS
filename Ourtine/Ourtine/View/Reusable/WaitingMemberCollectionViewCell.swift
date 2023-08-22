//
//  WaitingMemberCollectionViewCell.swift
//  Ourtine
//
//  Created by eunji on 2023/08/10.
//

import UIKit
import SnapKit

class WaitingMemberCollectionViewCell: UICollectionViewCell {
    static let id = "WaitingMemberCell"
    
    var memberData = MemberModel("Crown", "bunny", "bunny", 1)
    
    private let memberProfile: UserProfileImageView = {
        let view = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 72, height: 72))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let memberName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("iniit(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.memberProfile)
        self.contentView.addSubview(self.memberName)
        
        setConstraints()
    }
    
    func getMemberData(data: MemberModel) {
        self.memberData = data
        self.fetchData()
    }
    
    private func fetchData() {
        self.memberName.text = self.memberData.name
        self.memberProfile.setImage(image: UIImage(named: self.memberData.image ?? "bunny"))
    }
    
    private func setConstraints() {
        // memberProfile
        memberProfile.snp.makeConstraints { make in
//            make.top.equalTo(self.contentView.snp.top).offset(40.4)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(72)
        }
        
        // memberName
        memberName.snp.makeConstraints { make in
            make.top.equalTo(memberProfile.snp.bottom).offset(8)
            make.centerX.equalTo(memberProfile.snp.centerX)
        }
    }
    
}
