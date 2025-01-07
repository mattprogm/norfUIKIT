import Foundation

//MARK: - NETWORK


struct UserModel: Codable {
    let sucesso: String
    let userID: String
    let nome: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case sucesso = "sucesso"
        case userID = "UserID"
        case nome = "Nome"
        case token = "Token"
    }
}

