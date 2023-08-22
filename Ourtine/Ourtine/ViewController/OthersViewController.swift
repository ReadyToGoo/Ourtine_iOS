//
//  OthersViewController.swift
//  Ourtine
//
//  Created by eunji on 2023/08/21.
//

import UIKit
import SnapKit
import AVKit

class OthersViewController: UIViewController {
    var selectedMember: MemberModel?
    var player: AVPlayer?
    var timeObserverToken: Any?
    
    var videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
//    var videoURL = URL(string: "https://techslides.com/demos/sample-videos/small.mp4")
    
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
            player?.play()
            
            setupTimeObserver()
            
            player?.currentItem?.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
        }
        
        view.addSubview(timelineProgressBar)
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func setupTimeObserver() {
        let interval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            guard let player = self?.player else { return }
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero)
            let progress = Float(currentTime / duration)
            
            // Update the timeline progress bar UI
            self?.timelineProgressBar.setProgress(progress, animated: true)
            
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
