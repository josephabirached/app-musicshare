//
//  SongViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 20/01/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class SongViewController: UIViewController{
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var id = Int()
    var song = ""
    var artist = ""
    var imageUI = ""
    
    
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
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            self.songImage.image = UIImage(data: data!)
          }
        }
    }
    
}
