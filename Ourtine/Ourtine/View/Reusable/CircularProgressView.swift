//
//  CircularProgressView.swift
//  Ourtine
//
//  Created by eunji on 2023/08/04.
//

import UIKit

class CircularProgressView: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "65%")
        let bigFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        attributedString.addAttribute(.font, value: bigFont, range: NSRange(location: 0, length: 3))
        let smallFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        attributedString.addAttribute(.font, value: smallFont, range: NSRange(location: 2, length: 1))
        label.attributedText = attributedString
        
        return label
    }()
    
    func createCircularPath() {
        self.backgroundColor = UIColor.clear
//        self.layer.cornerRadius = self.frame.size.width/2.0
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0), radius: 30, startAngle: CGFloat(-0.5 * Double.pi), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 30, y: 28), radius: 30, startAngle: CGFloat(-0.5 * Double.pi), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10.0;
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0;
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
        addSubview(percentLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
        setConstraint()
    }
    
    var progressColor: UIColor = UIColor.orange {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    func updateProgress(to value: CGFloat) {
        let clampedValue = max(0, min(1, value))
        progressLayer.strokeEnd = clampedValue
    }
    
    func setConstraint() {
        percentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    

}
