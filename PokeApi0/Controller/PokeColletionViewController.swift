import UIKit

class PokeColletionViewController: UIViewController {

    @IBOutlet weak var colletionView: UICollectionView!
    let pokemonManager = PokemonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        colletionView.dataSource = self
        colletionView.delegate = self
        pokemonManager.fetchPokemon()
    }
}

extension PokeColletionViewController : PokemonManagerDelegate{
    func onFetchSuccess(result: [Pokemon]?) {
        DispatchQueue.main.async {
            self.colletionView.reloadData()
        }
    }
    
    func onError(error: Error) {
        print(error)
    }
    
    
}

extension PokeColletionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonManager.pokemonList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokecell", for: indexPath) as! PokeCell
        let poke = pokemonManager.pokemonList[indexPath.row]
        cell.updateUI(name: poke.name!,imageUrl: poke.imageUrl!)
        return cell
    }
    
    
}


extension PokeColletionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow : CGFloat = 3.0
        let paddingSpace = 20 * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}
