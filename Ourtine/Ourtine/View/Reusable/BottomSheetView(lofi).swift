//
//  BottomSheetVeiw.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/22.
//

import UIKit
import SnapKit

/// 바텀시트에 들어갈 뷰입니다.
/// lo-fi 용으로, 추후에 변경해야 합니다.
class BottomSheetView: UIView {
    
    // 바텀시트 제목 라벨
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "시트 제목"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 바텀시트 1번 버튼
    lazy var firstBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("아이템 1", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setBackgroundColor(.clear, for: .normal)
        return btn
    }()
    
    // 바텀시트 2번 버튼
    lazy var secondBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("아이템 2", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setBackgroundColor(.clear, for: .normal)
        return btn
    }()
    
    // 바텀시트 3번 버튼
    lazy var thirdBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("아이템 3", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setBackgroundColor(.clear, for: .normal)
        return btn
    }()
    
    private func addSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(firstBtn)
        self.addSubview(secondBtn)
        self.addSubview(thirdBtn)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        firstBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        secondBtn.snp.makeConstraints {
            $0.top.equalTo(firstBtn.snp.bottom).offset(0)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        thirdBtn.snp.makeConstraints {
            $0.top.equalTo(secondBtn.snp.bottom).offset(0)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
    
    func setContents(title: String, options: [String?]) {
        self.titleLabel.text = title
        firstBtn.setTitle(options[0] ?? "", for: .normal)
        secondBtn.setTitle(options[1] ?? "", for: .normal)
        thirdBtn.setTitle(options[2] ?? "", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct BottomSheetView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = BottomSheetView()
            return view
        }
        .previewLayout(.sizeThatFits)
    }
}
