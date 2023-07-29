//
//  AlarmTableViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/29.
//

import UIKit
import SnapKit

/// HabitAlarmTableView의 cell입니다.
/// ViewController : HabitAlarmViewController
class AlarmTableViewCell: UITableViewCell {
    
    //셀의 기본 높이와 identifier입니다.
    static let cellHeight:CGFloat = 150
    static let identifier:String = "AlarmTableViewCell"
    
    // cell data init용
    var cellData = AlarmModel("알림 제목", "날짜", "ㅁㄴㅇㄹ")
    
    lazy var titleLabel: UILabel = {
       let title = UILabel()
        title.text = "알림 제목"
        title.font = .systemFont(ofSize: 20)
        title.textColor = .black
        return title
    }()
    
    lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.text = "날짜"
        label.textColor = .black
        //label.font = .systemFont(ofSize: )
        return label
    }()
    
    lazy var contentLabel: UILabel = {
       let label = UILabel()
        label.text = """
                        adsf
                        asdfsadsadfsadfsdaafsida
                        asdfasfdasffsdafdasfsdfafasadff
                    """
        label.numberOfLines = 3
        label.textColor = .black
        //label.font = .systemFont(ofSize: )
        return label
    }()
    
    // 셀에 컴포넌트 요소 등록
    private func addViews() {
        self.backgroundColor = .white // 셀 배경 흰색
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
        self.addSubview(contentLabel)
    }
    
    // 컴포넌트 Constraints
    private func setConstraints(){
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().offset(15)
        }
    }
    
    /// 셀 컴포넌트 요소에 데이터 페칭
    private func fetchData() {
        self.titleLabel.text = self.cellData.title
        self.dateLabel.text = self.cellData.date
        self.contentLabel.text = self.cellData.content
    }
    
    /// TableViewController에서 Cell data 페칭을 위한 함수
    func getCellData(data: AlarmModel) {
        self.cellData = data
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
struct AlarmTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            return AlarmTableViewCell()
        }
        .previewLayout(.fixed(width: 400, height: AlarmTableViewCell.cellHeight))

    }
}
