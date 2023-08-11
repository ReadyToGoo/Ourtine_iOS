//
//  weeklyStatusStackCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/08/11.
//

import UIKit
import SnapKit

class WeeklyStatusStackCell: UIView {
    
    var dotsList: [UIView] = []
    
    var habitCount: Int = 0 {
        didSet {
           showDots()
        }
    }
    
    // 요일 라벨
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.textColor = .app_BrightnessColor100
        return label
    }()
    
    // 아래 점 들어가는 뷰
    lazy var dotsView: UIView = {
        let view = UIView()
        view.backgroundColor = .app_BrightnessColor0
        return view
    }()
    
    // 점
    lazy var d1: UIImageView = {
        let dot = UIImageView()
        dot.image = createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 13, height: 13))?.circularCropped()
        return dot
    }()

    lazy var d2: UIImageView = {
        let dot = UIImageView()
        dot.image = createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 13, height: 13))?.circularCropped()
        return dot
    }()
    
    lazy var d3: UIImageView = {
        let dot = UIImageView()
        dot.image = createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 13, height: 13))?.circularCropped()
        return dot
    }()
    
    lazy var d4: UIImageView = {
        let dot = UIImageView()
        dot.image = createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 13, height: 13))?.circularCropped()
        return dot
    }()
    
    
    lazy var d5: UIImageView = {
        let dot = UIImageView()
        dot.image = createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 13, height: 13))?.circularCropped()
        return dot
    }()
    
    lazy var d6: UIImageView = {
        let dot = UIImageView()
        dot.image = createImageWithColor(color: .app_SecondaryColor2, size: CGSize(width: 13, height: 13))?.circularCropped()
        return dot
    }()
    
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        [
            d1,
            d2,
            d3,
            d4,
            d5,
            d6
        ].forEach { dotsView.addSubview($0) }
        
        
        [
            dayLabel,
            dotsView
        ].forEach { self.addSubview($0) }
        
        self.backgroundColor = .white // 셀 배경 흰색
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        dayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        
        dotsView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        d1.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    
        d3.snp.makeConstraints {
            $0.centerX.equalTo(d1)
            $0.bottom.equalTo(d1.snp.top).offset(-5)
        }
        
        d5.snp.makeConstraints {
            $0.centerX.equalTo(d3)
            $0.bottom.equalTo(d3.snp.top).offset(-5)
        }
        
        d2.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        d4.snp.makeConstraints {
            $0.centerX.equalTo(d2)
            $0.bottom.equalTo(d2.snp.top).offset(-5)
        }
        
        d6.snp.makeConstraints {
            $0.centerX.equalTo(d4)
            $0.bottom.equalTo(d4.snp.top).offset(-5)
        }
    }
    
    // count에 따라 점 갯수 보이게
    private func showDots() {
        for (index, view) in dotsList.enumerated() {
            view.isHidden = index >= habitCount
        }
    }
    
    /// Cell data 페칭을 위한 함수
    func getCellData(data: Int) {
        self.habitCount = data
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
        self.dotsList = [d1,d2,d3,d4,d5,d6]
        self.backgroundColor = .app_SecondaryColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct WeeklyStatusStackCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = WeeklyStatusStackCell()
            cell.getCellData(data: 4)
            return cell
        }
        .previewLayout(.fixed(width: 40, height: 150))

    }
}
