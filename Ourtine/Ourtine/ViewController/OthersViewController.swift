//
//  OthersViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/21.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation

class OthersViewController: UIViewController {
    var selectedMember: MemberModel?
    var player: AVPlayer?
    var timeObserverToken: Any?
    var initialTouchPoint: CGPoint = CGPoint.zero
    
    var videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
//    var videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    
    let timelineProgressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = .white
        progressBar.trackTintColor = .white.withAlphaComponent(0.4)
    
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let videoURL = selectedMember?.videoURL {
        if let videoURL = videoURL {
            player = AVPlayer(url: videoURL)
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
            
            // Start playing the video automatically
            player?.volume = 1.0
            player?.play()
            
            setupTimeObserver()
            forSilentMode()
            
            player?.currentItem?.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
        }
        
        view.addSubview(timelineProgressBar)
        setupConstraints()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timelineProgressBar.setProgress(0.0, animated: false)
        player?.play()
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("HandlePanCalled")
        let touchPoint = gestureRecognizer.location(in: self.view.window)
        
        if gestureRecognizer.state == .began {
            initialTouchPoint = touchPoint
        } else if gestureRecognizer.state == .changed {
            let yOffset = touchPoint.y - initialTouchPoint.y
            if yOffset > 100 {
                // Dismiss the view when the downward drag threshold is reached
                dismiss(animated: true, completion: nil)
            }
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            initialTouchPoint = CGPoint.zero
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player?.pause() // Pause the player when the view is about to disappear
        removeTimeObserver()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status", let playerItem = player?.currentItem {
            if playerItem.status == .readyToPlay {
                // Start playing the video automatically
                player?.play()
            }
        }
    }
    
    func forSilentMode() {
        // 무음모드일 때에도 소리 나도록.
        do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print("Error setting audio session category: \(error)")
        }
    }
    
    func setupTimeObserver() {
        let interval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            guard let player = self?.player else { return }
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero)
            let progress = Float(currentTime / duration)
            
            // Update the timeline progress bar UI
            self?.timelineProgressBar.setProgress(progress, animated: false)
            
            if currentTime >= duration {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func removeTimeObserver() {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    func setupConstraints() {
        timelineProgressBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(4)
        }
    }
}
