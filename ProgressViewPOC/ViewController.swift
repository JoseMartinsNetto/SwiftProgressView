//
//  ViewController.swift
//  ProgressViewPOC
//
//  Created by Jose Martins on 31/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var progressView: ProgressView!
    
    @IBOutlet var playPauseButton: UIButton!
    
    @IBOutlet var progressLabel: UILabel!
    
    var isPlaying = false
    var currentProgress: CGFloat = 0
    
    private var playerTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.trackColor = .lightGray
        progressView.progressColor = .systemIndigo
        progressView.progressWidth = 5
    }

    private func changePlayerIcon() {
        UIView.animate(withDuration: 0.3) {
            if self.isPlaying {
                self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            } else {
                self.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isPlaying = !self.isPlaying
        }
    }
    
    @IBAction func playPause(_ sender: Any) {
        changePlayerIcon()
        
        if self.isPlaying {
            playerTimer?.invalidate()
            return
        }
        
        playerTimer = Timer(timeInterval: 1, target: self, selector: #selector(increaseProgress), userInfo: nil, repeats: true)
        RunLoop.current.add(playerTimer!, forMode: .default)
        
    }
    
    @objc func increaseProgress() {
        if currentProgress >=  1 {
            playerTimer?.invalidate()
            return
        }
        
        currentProgress += 0.1
        progressView.setProgress(currentProgress)
        
        progressLabel.text = progressView.currentPercentText
        
        print(currentProgress)
    }
    
}

