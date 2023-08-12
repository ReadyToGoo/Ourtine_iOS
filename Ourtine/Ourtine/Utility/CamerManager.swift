//
//  CamerManager.swift
//  Ourtine
//
//  Created by eunji on 2023/08/12.
//

import UIKit
import AVFoundation

protocol CameraDelegate: AnyObject {
    func didCaptureImage (_ image: UIImage)
    func cameraAuthorizationStatus (_ isAuthroized: Bool)
}

class CameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate: CameraDelegate?
    
    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            delegate?.cameraAuthorizationStatus(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
                DispatchQueue.main.async {
                    self?.delegate?.cameraAuthorizationStatus(isAuthorized)
                }
            }
        default:
            delegate?.cameraAuthorizationStatus(false)
        }
    }
    
    func openCamera(from viewController: UIViewController) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.mediaTypes = ["public.image"]
        pickerController.allowsEditing = false
        pickerController.delegate = self
        viewController.present(pickerController, animated: true)
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        delegate?.didCaptureImage(image)
        picker.dismiss(animated: true, completion: nil)
    }
}

