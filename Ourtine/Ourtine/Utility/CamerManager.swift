//
//  CamerManager.swift
//  Ourtine
//
//  Created by eunji on 2023/08/12.
//

import UIKit
import AVFoundation
import Photos

protocol CameraDelegate: AnyObject {
    func didCaptureImage (_ image: UIImage)
    func didCaptureVideo (at url: URL)
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
    
    // Camera Setting
    func openCamera(from viewController: UIViewController, captureVideo: Bool = true) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.showsCameraControls = true
        
        if captureVideo {
            // take Video
            pickerController.mediaTypes = ["public.movie"]
        } else {
            // take photo
            pickerController.cameraCaptureMode = .photo
            pickerController.mediaTypes = ["public.image"]
        }
       
        pickerController.allowsEditing = false
        pickerController.delegate = self
        viewController.present(pickerController, animated: true)
        
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            delegate?.didCaptureVideo(at: videoURL)
            saveVideoToAlbum(videoURL)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            delegate?.didCaptureImage(image)
            saveImageToAlbum(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func saveImageToAlbum(_ image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { success, error in
            if success {
                print("Image saved to album successfully")
            } else if let error = error {
                print("Error saving image to album: \(error.localizedDescription)")
            }
        })
    }
    
    private func saveVideoToAlbum(_ videoURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }, completionHandler: { success, error in
            if success {
                print("Video saved to album successfully")
            } else if let error = error {
                print("Error saving video to album: \(error.localizedDescription)")
            }
        })
    }
    
}

