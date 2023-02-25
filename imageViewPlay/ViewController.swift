//
//  ViewController.swift
//  imageViewPlay
//
//  Created by Paul Sons on 2/25/23.
//

import UIKit

/**
 Credit for async image loading to:
 https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
 */
class ViewController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bannerImage.contentMode = UIView.ContentMode.scaleAspectFill
        let urlString = "https://www.nps.gov/common/uploads/cropped_image/primary/55B6E49B-C6F3-38B9-82A9F7F3D7BDC873.jpg"
        if let url = URL(string: urlString) {
            downloadImage(from: url)
        } else {
            print("Unable to make a URL out of string \(urlString)")
        }
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.bannerImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

