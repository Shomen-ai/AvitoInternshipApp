import Foundation

final class NetworkService {
    
    func request(completion: @escaping (Result<Company, Error>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch json.\n", error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let decodedString = try JSONDecoder().decode(Company.self, from: data)
                    completion(.success(decodedString))
                } catch let jsonError {
                    print("Failed to decode json.\n", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}



