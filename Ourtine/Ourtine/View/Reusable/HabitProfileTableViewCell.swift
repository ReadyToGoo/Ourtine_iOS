//
//  HabitProfileTableViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/15.
//

import UIKit

/// 습관 검색 결과를 표시할 테이블뷰 셀
/// 해당 셀은 searchResultTableView안에 표시됩니다.
/// ViewController : SearchResultView
class HabitProfileTableViewCell: UITableViewCell {
    
    //셀의 기본 높이와 identifier입니다.
    static let cellHeight:CGFloat = 80
    static let identifier:String = "HabitProfileTableViewCell"
    
    // cell data init용
    var habitData = HabitModel(9999, nil, "DEFAULT", "#default")
    
    // habitImage 생성
    private let habitImage: HabitProfileImageView = {
        let imgView = HabitProfileImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.tintColor = .black
        return imgView
    }()
        
    // habitName 생성
    private let habitName: UILabel = {
        let label = UILabel()
        //label.text = "Title Title Title"
        label.textColor = UIColor.black
        return label
    }()
    
    // habitHashTagLine 생성
    private let habitHashTagLine: UILabel = {
        let label = UILabel()
        //label.text = "#hash #hash #hash"
        label.textColor = UIColor.gray
        return label
    }()
    
    // 우측 버튼 생성
    private let chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitle(nil, for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        self.habitName.text = self.habitData.habitName
        self.habitImage.setImage(image: nil) // 나중에 URL로
        self.habitHashTagLine.text = self.habitData.hastags
    }
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white
        self.addSubview(habitImage)
        self.addSubview(habitName)
        self.addSubview(habitHashTagLine)
        self.addSubview(chevronButton)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        habitImage.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        habitName.snp.makeConstraints { make in
            make.leading.equalTo(habitImage.snp.trailing).offset(15)
            make.top.equalTo(habitImage.snp.top).offset(10)
        }
        habitHashTagLine.snp.makeConstraints { make in
            make.leading.equalTo(habitName.snp.leading)
            make.top.equalTo(habitName.snp.bottom).offset(5)
        }
        chevronButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getHabitData(data: HabitModel) {
        self.habitData = data
        self.fetchData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.fetchData()
        self.addViews()
        self.setConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct HabitProfileTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            return HabitProfileTableViewCell()
        }
        .previewLayout(.fixed(width: 400, height: HabitProfileTableViewCell.cellHeight))
    }
}
