//
//  ParticipatingMemberCollectionViewCell.swift
//  Ourtine
//
//  Created by eunji on 2023/08/11.
//

import UIKit

class ParticipatingMemberViewCell: UICollectionViewCell {
    
    static let id = "ParticipatingMemberCell"
    
    weak var delegate: ParticipatingMemberCollectionViewDelegate?
    
    var buttonAction: (() -> Void)?
    
    var memberData = MemberModel("crown", nil, "what")
    
    var shouldShowSelectedImage: Bool = false {
        didSet {
            updateSelectedImageVisibility()
        }
    }
    
    var isSelectedCell: Bool = false {
        didSet {
            updateSelectedImageVisibility()
        }
    }
    
    private let memberProfileBtn: UserProfileImageView = {
        let view = UserProfileImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.frame.height/2
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let nonCheckImage: UIImageView = {
        let view = UIImageView()
        view.image = createImageWithColor(color: .app_PrimaryColor.withAlphaComponent(0.8), size: CGSize(width: 32, height: 32))?.circularCropped()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        return view
    }()
    
    private let checkBackground: UIImageView = {
        let view = UIImageView()
        view.image = createImageWithColor(color: .app_SecondaryColor2.withAlphaComponent(0.8), size: CGSize(width: 32, height: 32))?.circularCropped()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        return view
    }()
    
    private let checkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check")
        return view
    }()
    
    private let memberName: UILabel = {
        let label = PaddingLabel(withInsets: 4, 4, 10, 10)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white.withAlphaComponent(0.35)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 13
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.25
        label.layer.shadowRadius = 2
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.memberProfileBtn)
        self.contentView.addSubview(self.memberName)
        
        setConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
        
        isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelectedCell = false
    }
    
    @objc private func cellTapped() {
        isSelectedCell.toggle()
//        let selectedmemberData = isSelectedCell ? memberData : nil
        delegate?.didSelectMember(memberData)
        updateSelectedImageVisibility()
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
        memberProfileBtn.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(110)
        }
        
        memberName.snp.makeConstraints { make in
            make.top.equalTo(memberProfileBtn.snp.bottom).offset(4)
            make.centerX.equalTo(memberProfileBtn.snp.centerX)
        }
    }
    
    private func updateSelectedImageVisibility() {
        if shouldShowSelectedImage {
            if isSelectedCell {
                contentView.addSubview(checkBackground)
                contentView.addSubview(checkImage)
                checkBackground.snp.makeConstraints { make in
                    make.center.equalTo(memberProfileBtn)
                    make.size.equalTo(CGSize(width: 32, height: 32))
                }
                checkImage.snp.makeConstraints { make in
                    make.center.equalTo(checkBackground)
                    make.size.equalTo(CGSize(width: 16, height: 12))
                }
                nonCheckImage.isHidden = true
                checkBackground.isHidden = false
                checkImage.isHidden = false
            } else {
                contentView.addSubview(nonCheckImage)
                nonCheckImage.snp.makeConstraints { make in
                    make.center.equalTo(memberProfileBtn)
                    make.size.equalTo(CGSize(width: 32, height: 32))
                }
                nonCheckImage.isHidden = false
                checkBackground.isHidden = true
                checkImage.isHidden = true
            }
        }
    }
    
}
