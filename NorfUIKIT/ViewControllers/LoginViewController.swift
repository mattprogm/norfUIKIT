import UIKit

class LoginViewController: UIViewController {
    
    private var loginView: LoginView!
    var userModel: UserLogin?

    
    var userID = ""
    var username = ""
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializando a LoginView
        loginView = LoginView()
        loginView.frame = view.bounds
        loginView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(loginView)
        
        // Adicionando ação ao botão "Entrar"
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Ação do Botão
    @objc private func loginButtonTapped() {
        // Aqui você pode adicionar a lógica para chamar a API ou qualquer outra ação
        print("Botão de login pressionado")
        loginRequest()
        print(username, userID, token)
        // Exemplo de navegação para a próxima tela após o login (ou algo que você queira fazer)
        // let homeViewController = HomeViewController()
        // navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    //MARK: - net func
    
    
    
    
    func loginRequest() {
        let url = URL(string: "https://app.norf.com.br/api/login.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Dados que serão enviados
        let parameters = [
            "user": "Luana@tst.com.br",
            "password": "102030"
        ]
        
        // Configuração dos cabeçalhos
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Codificar os parâmetros para o formato URL encoded
        let bodyString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        // Executar a requisição
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
                
                let cleanedData = self.removeBOM(from: data)
                
                do {
                    // Tentar decodificar o JSON
                    let jsonResponse = try JSONSerialization.jsonObject(with: cleanedData, options: []) as? [String: Any]
                    
                    if let jsonResponse = jsonResponse {
                        
                        // Extrair os dados necessários
                        if let sucesso = jsonResponse["sucesso"] as? String,
                           let userID = jsonResponse["UserID"] as? String,
                           let nome = jsonResponse["Nome"] as? String,
                           let token = jsonResponse["Token"] as? String {
                            
                            // Verificar se o login foi bem-sucedido
                            let sucessoLogin = sucesso == "true" // Converte a string "true" para booleano
                            
                            // Salvar os dados em variáveis
                            self.userID = userID
                            self.username = nome
                            self.token = token
                            
                            // Exibir os valores para verificar
                            print("Sucesso: \(sucessoLogin)")
                            print("User ID: \(self.userID)")
                            print("Nome: \(self.username)")
                            print("Token: \(self.token)")
                        } else {
                            print("Falha ao encontrar algum dado esperado na resposta.")
                        }
                    }
                } catch let jsonError {
                    print("Erro ao processar o JSON: \(jsonError.localizedDescription)")
                    
//                    if let rawResponse = String(data: cleanedData, encoding: .utf8) {
//                        print("Resposta limpa ao falhar na decodificação do JSON: \(rawResponse)")
//                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    
    
        func removeBOM(from data: Data) -> Data {
        var cleanedData = data
        if cleanedData.count > 3 && cleanedData[0] == 0xEF && cleanedData[1] == 0xBB && cleanedData[2] == 0xBF {
            cleanedData.removeSubrange(0..<3) // Remove o BOM
        }
        return cleanedData
    }

    
}



struct UserLogin: Codable {
    let sucesso: String
    let username: String
    let token: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case sucesso
        case username = "Nome" // Nome da API mapeado para username
        case token = "Token"
        case userID = "UserID"
    }
}
