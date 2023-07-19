//
//  UIViewController+Preview.swift
//  Ourtine
//
//  Created by 박민서 on 2023/07/13.
//

//MARK: XCode에서 Preview 표시를 위한 코드입니다. - ViewController 전용
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        //Not needed
    }

    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
}
#endif
