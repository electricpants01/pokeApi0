import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var pokemonManager = PokemonManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        pokemonManager.delegate = self
        pokemonManager.fetchPokemon()
    }
}

extension ViewController: PokemonManagerDelegate {
    func onFetchSuccess(result: [Pokemon]?) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func onError(error: Error) {
        print(error)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonManager.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "pokeCell")
        let poke = pokemonManager.pokemonList[indexPath.row]
        cell.textLabel?.text = "\(poke.name!) \(poke.id!)"
        if let imageUrl = poke.imageUrl {
            cell.imageView?.load(url: imageUrl, onLoad: {
                [weak cell] image in cell?.setNeedsLayout()
            })
        }
        return cell
    }
}
