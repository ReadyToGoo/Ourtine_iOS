//
//  RecentSearchResult.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/21.
//

import UIKit
import SnapKit

/// 유저 검색 결과를 표시할 테이블뷰 셀
/// 해당 셀은 searchResultTableView안에 표시됩니다.
class RecentSearchTableViewCell: UITableViewCell {
    
    //셀의 기본 높이와 identifier입니다.
    static let cellHeight:CGFloat = 40
    static let identifier:String = "RecentSearchTableViewCell"
    
    
    // searchedText  생성
    let searchedText: UILabel = {
        let label = UILabel()
        label.text = "test용입니다"
        label.textColor = UIColor.black
        return label
    }()
    
    // 우측 화살표 버튼 생성
    let deleteButton: UIButton = {
        let button = UIButton()
        
        button.frame.size = CGSize(width:30, height: 30)
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
    
        button.setTitle(nil, for: .normal)
        button.tintColor = .lightGray.withAlphaComponent(0.5)
        
        return button
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white // 셀 배경 흰색
        self.contentView.addSubview(searchedText)
//        self.contentView.addSubview(deleteButton)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        searchedText.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        
//        deleteButton.snp.makeConstraints {
//            $0.trailing.equalToSuperview().offset(-15)
//            $0.centerY.equalToSuperview()
//        }
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getTextData(data: SearchedText) {
        self.searchedText.text = data.content
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addViews()
        self.setConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct RecentSearchTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            return RecentSearchTableViewCell()
        }
        .previewLayout(.fixed(width: 400, height: RecentSearchTableViewCell.cellHeight))

    }
}
