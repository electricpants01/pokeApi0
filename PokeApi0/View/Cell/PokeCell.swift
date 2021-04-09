 
import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func updateUI(name : String, imageUrl : String){
        nameLabel.text = name
        imageView.load(url: imageUrl, onLoad: nil)
    }
    
}
