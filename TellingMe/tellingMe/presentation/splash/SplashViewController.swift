//
//  SplashViewController.swift
//  tellingMe
//
//  Created by 마경미 on 14.06.23.
//

import UIKit
import AVFoundation

class SplashViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
//        performAutoLogin()
    }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "Splash", ofType: "mp4") else {
            return
        }

        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = imageView.bounds
        imageView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.pause()
            playerLayer.removeFromSuperlayer()
            self.performAutoLogin()
        }

        player.play()
    }

}
