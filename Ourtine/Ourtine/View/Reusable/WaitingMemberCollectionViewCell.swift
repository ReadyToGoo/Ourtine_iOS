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
    
    var memberData = MemberModel("crown",nil,"what")
    
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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        self.prepare(image: nil, text: nil)
//    }
    
//    func prepare(image: UIImage?, text: String?) {
//        self.memberProfile.image = image
//        self.memberName.text = text
//    }
    
    func getMemberData(data: MemberModel) {
        self.memberData = data
        self.fetchData()
    }
    
    private func fetchData() {
        self.memberName.text = self.memberData.name
        self.memberProfile.setImage(image: nil)
    }
    
    private func setConstraints() {
        // memberProfile
        memberProfile.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(13)
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
