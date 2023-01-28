//
//  WelcomeViewController.swift
//  SomaStoryboards
//
//  Created by Michael Brockman on 1/28/23.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  var model = WelcomeViewModel()
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.cvPictures.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeImageCVCell", for: indexPath) as? WelcomeImageCVCell else { return UICollectionViewCell() }
    
    cell.imageView = UIImageView(image: model.cvPictures[indexPath.item])
    
    return cell
    
  }
  
  
}
