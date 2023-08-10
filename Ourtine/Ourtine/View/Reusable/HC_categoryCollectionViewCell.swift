//
//  HC_categoryCollectionViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/31.
//

import UIKit
import SnapKit

/// 습관 개설 플로우  중 카테고리 선택 탭의 카테고리 콜렉션 뷰 셀입니다.
class HabitCreateCategoryCVCell: UICollectionViewCell {
    
    //셀 사이즈
    static let cellHeight = 150.0
    static let cellWidth = 200.0
    
    ///식별자
    static let identifier:String = "HabitCreateCategoryCVCell"
    
    ///셀 데이터
    var cellData = HC_Category("습관 이름")
    
    // 셀 내부에서 사용되는 gotChosen 속성 - 해당 셀이 선택되었는지
    var gotChosen: Bool = false {
        didSet {
            //print(gotChosen)
            updateCellState(isSelected: gotChosen)
        }
    }
    
    ///셀 텍스트
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "습관 이름"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    /// 셀 배경뷰
    lazy var categoryView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .app_SecondaryColor
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    /// 셀 강조뷰
    lazy var highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = .app_BrightnessColor60.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.app_PrimaryColor.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .clear // 셀 배경 흰색
        self.addSubview(categoryView)
        self.addSubview(highlightView)
        self.addSubview(titleLabel)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        categoryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        highlightView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// Cell data 페칭을 위한 함수
    func getCellData(data: HC_Category) {
                self.cellData = data
                self.fetchData()
    }
    
    
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        //self.frontImage.image = self.cardData.image
        self.titleLabel.text = self.cellData.name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
        
        self.highlightView.isHidden = true
    }
    
    func updateCellState(isSelected: Bool) {
        if isSelected {
            self.highlightView.isHidden = false
            self.titleLabel.textColor = .app_PrimaryColor
        }
        else {
            self.highlightView.isHidden = true
            self.titleLabel.textColor = .white
        }
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct HabitCreateCategoryCollectionViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = HabitCreateCategoryCVCell()
            //cell.getMemberData(data: MemberModel("Crown", nil, "Test"))
            cell.getCellData(data: Dummy_HC_Categories[0])
            return cell
        }
        .previewLayout(.fixed(width: HabitCreateCategoryCVCell.cellWidth, height: CGFloat(HabitCreateCategoryCVCell.cellHeight)))

    }
}
