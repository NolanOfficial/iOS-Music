//
//  GenreScreen.swift
//  iOS Music
//
//  Created by Nolan Fuchs on 11/13/18.
//  Copyright © 2018 Nolan Fuchs. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreScreen: UIViewController {

    // Music Controller
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    
    // Items
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var timeOfSong: UISlider!
    @IBOutlet weak var currentSongTime: UILabel!
    @IBOutlet weak var remainingSongTime: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistAndAlbumLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    let size = CGSize(width: 300, height: 300)
    var toggleState = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timeOfSong.maximumValue = Float(musicPlayer.nowPlayingItem?.playbackDuration ?? 0.0)
        print(timeOfSong.maximumValue)
        changeLabels()
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        var playBtn = sender as UIButton
        if toggleState == 1 {
            musicPlayer.play()
            toggleState = 2
            playBtn.setImage(UIImage(named: "pause.png"), for: .normal)
        } else {
            musicPlayer.pause()
            toggleState = 1
            playBtn.setImage(UIImage(named: "play.png"), for: .normal)
        }
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        musicPlayer.stop()
        musicPlayer.prepareToPlay()
        musicPlayer.skipToNextItem()
        musicPlayer.play()
        
        //Changing Variables
       changeLabels()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        musicPlayer.stop()
        musicPlayer.skipToPreviousItem()
        musicPlayer.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.changeLabels()
        }
    }
    
    // Changing the volume with slider
    @IBAction func changeVolume(_ sender: UISlider) {
    MPVolumeView.setVolume(volumeSlider.value)
        print(volumeSlider.value)
    }
    
    // Changing label values to current song
    func changeLabels() {
        let timeRemaining: Int = Int((musicPlayer.nowPlayingItem?.playbackDuration ?? 0)/60)
        let timeRemainingSeconds: Int = Int(musicPlayer.nowPlayingItem?.playbackDuration ?? 0) % 60
        if timeRemainingSeconds < 10 {
            remainingSongTime.text = "\(timeRemaining):0\(timeRemainingSeconds)"
        } else {
            remainingSongTime.text = "\(timeRemaining):\(timeRemainingSeconds)"
        }
        songNameLabel.text = musicPlayer.nowPlayingItem?.title ?? "Song Name"
        artistAndAlbumLabel.text = "\(musicPlayer.nowPlayingItem?.albumArtist ?? "Artist Name") - \(musicPlayer.nowPlayingItem?.albumTitle ?? "Album Name")"
        albumCoverImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: size)
        
    }

}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
