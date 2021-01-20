//
//  SongViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 20/01/2021.
//

import UIKit
import FirebaseDatabase

class SongViewController: UIViewController{
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var id = Int()
    var song = ""
    var artist = ""
    var imageUI = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songTitle?.text = song
        self.artistName?.text = artist
        self.songImage?.image = imageUI
    }
    
}
