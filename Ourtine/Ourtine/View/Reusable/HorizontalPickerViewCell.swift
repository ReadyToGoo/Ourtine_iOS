//
//  HorizontalPickerViewCell.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/26.
//

import UIKit
import SnapKit

/// habitSegmentCollectionView의 Cell 입니다
/// ViewController : HabitDiscoverViewController
final class HorizontalPickerViewCell: UICollectionViewCell {
    /// Cell identifier
    static let identifier = String(describing: HorizontalPickerViewCell.self)
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    public let underLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemOrange.withAlphaComponent(0.8)
        line.layer.cornerRadius = 2.5
        return line
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.centerY.equalTo(titleLabel).offset(18)
            $0.width.equalTo(titleLabel)
            $0.height.equalTo(3)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        titleLabel.attributedText = nil
//    }
    
    /// 셀의 내용을 설정합니다.
    /// + 해당 셀이 선택 되었는지에 따라(isSelected: Bool) 밑선을 추가합니다.
    public func configure(with title: String, isSelected: Bool = false) {
        titleLabel.text = title
        titleLabel.textColor = isSelected ? .systemOrange : .black
        titleLabel.font = isSelected ? .systemFont(ofSize: 16, weight: .heavy) : .systemFont(ofSize: 15, weight: .medium)
        self.underLine.isHidden = isSelected ? false : true
    }
}


import SwiftUI // -> View 컴포넌트 하나만 볼 때
struct HorizontalPickerViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = HorizontalPickerViewCell()
            cell.titleLabel.text = "its test"
            return cell
        }
        .previewLayout(.sizeThatFits)

    }
}
