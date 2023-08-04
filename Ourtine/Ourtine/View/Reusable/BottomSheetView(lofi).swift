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
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // 바텀시트 1번 버튼
    lazy var firstBtn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.plain())
        btn.configuration?.imagePadding = 10
        btn.setTitle("아이템 1", for: .normal)
        btn.setTitleColor(.app_BrightnessColor60, for: .normal)
        btn.setImage(UIImage(systemName: "person"), for: .normal)
        btn.setBackgroundColor(.clear, for: .normal)
        btn.tintColor = .app_BrightnessColor60
        return btn
    }()
    
    // 바텀시트 2번 버튼
    lazy var secondBtn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.plain())
        btn.configuration?.imagePadding = 10
        btn.setTitle("아이템 2", for: .normal)
        btn.setTitleColor(.app_BrightnessColor60, for: .normal)
        btn.setImage(UIImage(systemName: "person"), for: .normal)
        btn.setBackgroundColor(.clear, for: .normal)
        btn.tintColor = .app_BrightnessColor60
        return btn
    }()
    
    // 바텀시트 3번 버튼
    lazy var thirdBtn: UIButton = {
        let btn = UIButton(configuration: UIButton.Configuration.plain())
        btn.configuration?.imagePadding = 10
        btn.setTitle("아이템 3", for: .normal)
        btn.setTitleColor(.app_BrightnessColor60, for: .normal)
        btn.setImage(UIImage(systemName: "person"), for: .normal)
        btn.setBackgroundColor(.clear, for: .normal)
        btn.tintColor = .app_BrightnessColor60
        return btn
    }()
    
    // 컴포넌트간 구분선
    lazy var line1 = makeLine()
    lazy var line2 = makeLine()
    lazy var line3 = makeLine()
    lazy var line4 = makeLine()
    
    // 구분선 생성자
    func makeLine() -> UIView {
        let line = UIView()
        line.backgroundColor = .app_BrightnessColor40
        return line
    }
    
    private func addSubviews() {
        [
            line1,
            line2,
            line3,
            line4,
            titleLabel,
            firstBtn,
            secondBtn,
            thirdBtn
        ].forEach{self.addSubview($0)}
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        line1.snp.makeConstraints {
            $0.top.equalTo(firstBtn)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        firstBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        line2.snp.makeConstraints {
            $0.bottom.equalTo(firstBtn)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        secondBtn.snp.makeConstraints {
            $0.top.equalTo(firstBtn.snp.bottom).offset(0)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        line3.snp.makeConstraints {
            $0.bottom.equalTo(secondBtn)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        thirdBtn.snp.makeConstraints {
            $0.top.equalTo(secondBtn.snp.bottom).offset(0)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        line4.snp.makeConstraints {
            $0.bottom.equalTo(thirdBtn)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
    }
    
    /// 해당 시트 외부에서 본 시트를 불러올때 데이터를 페칭하는 함수입니다.
    func setContents(title: String, optionsName: [String?], optionsImage: [String?]) {
        self.titleLabel.text = title
        
        firstBtn.setTitle(optionsName[0] ?? "", for: .normal)
        secondBtn.setTitle(optionsName[1] ?? "", for: .normal)
        thirdBtn.setTitle(optionsName[2] ?? "", for: .normal)
        
        firstBtn.setImage(UIImage(systemName: optionsImage[0] ?? ""), for: .normal)
        secondBtn.setImage(UIImage(systemName: optionsImage[1] ?? ""), for: .normal)
        thirdBtn.setImage(UIImage(systemName: optionsImage[2] ?? ""), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .app_BrightnessColor10.withAlphaComponent(0.95)
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
