//
//  ParticipatingMemberCollectionViewCell.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit

class ParticipatingMemberViewCell: UICollectionViewCell {
    static let id = "ParticipatingMemberCell"
    
    var memberData = MemberModel("crown",nil,"what")
    
    private let memberProfileBtn: UserProfileImageView = {
        let view = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.frame.height/2
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let memberName: UILabel = {
        let label = PaddingLabel(withInsets: 4, 4, 9.54, 9.54)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white.withAlphaComponent(0.35)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 16
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("iniit(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.memberProfileBtn)
        self.contentView.addSubview(self.memberName)
        
        setConstraints()
    }
    
    func getMemberData(data: MemberModel) {
        self.memberData = data
        self.fetchData()
    }
    
    private func fetchData() {
        self.memberName.text = self.memberData.name
        self.memberProfileBtn.setImage(image: nil)
    }
    
    private func setConstraints() {
        // memberProfile
        memberProfileBtn.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(110)
        }
        
        // memberName
        memberName.snp.makeConstraints { make in
            make.top.equalTo(memberProfileBtn.snp.bottom).offset(4)
            make.centerX.equalTo(memberProfileBtn.snp.centerX)
        }
    }
}
