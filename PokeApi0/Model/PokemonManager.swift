
import Foundation


class PokemonManager{
    var pokemonList: [Pokemon]
    var delegate: PokemonManagerDelegate?
    init() {
        pokemonList = []
    }
    
    func fetchPokemon() {
        performRequest(urlString: "https://pokeapi.co/api/v2/pokemon?limit=151")
    }
    
    func performRequest(urlString: String) {
        if let fetchURl = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: fetchURl, completionHandler: handleResponse)
            task.resume()
        }
    }
    
    func handleResponse(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            if let pokeApiResult = parseJSON(pokeApiData: safeData) {
                pokemonList = pokeApiResult.toPokemonArray()!
                delegate?.onFetchSuccess(result: pokemonList)
            }
        }
    }
    
    func parseJSON(pokeApiData: Data) -> PokeApiListResult? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokeApiListResult.self, from: pokeApiData)
            return decodedData
        } catch {
            delegate?.onError(error: error)
            print(error)
        }
        return nil
    }
}
