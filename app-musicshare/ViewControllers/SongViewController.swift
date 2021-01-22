//
//  SongViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 20/01/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import AVFoundation

class SongViewController: UIViewController{
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    var id = Int()
    var song = ""
    var artist = ""
    var imageUI = ""
    var songURL = ""
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songTitle?.text = song
        self.artistName?.text = artist
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(imageUI)

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print(error)
          } else {
            // Data for "images/island.jpg" is returned
            self.songImage.image = UIImage(data: data!)
          }
        }
        
        let songRef = storageRef.child(songURL)
        songRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error{
                print(error)
            } else {
                do{
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    
                    self.player = try AVAudioPlayer(data: data!)
                    
                    }
                catch let error{
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    @IBAction func togglePlaySong(_ sender: Any) {
        
        if(!player!.isPlaying){
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player!.play()
        }else{
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player?.pause()
        }
    }
    
    
}
