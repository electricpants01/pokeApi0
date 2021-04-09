import UIKit
import Foundation

extension UIImageView {
    func load(url: String, onLoad: ((UIImage) -> Void)?){
        if let imageUrl = URL(string: url) {
            myLoad(url: imageUrl, onLoad: onLoad)
        }
    }
    
    func myLoad(url: URL, onLoad: ((UIImage) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        onLoad?(image)
                    }
                }
            }
        }
    }
}
