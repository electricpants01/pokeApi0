import Foundation

protocol PokemonManagerDelegate {
    func onFetchSuccess(result: [Pokemon]?)
    func onError(error: Error)
}
