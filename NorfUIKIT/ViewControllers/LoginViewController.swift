import UIKit

class LoginViewController: UIViewController {
    
    private var loginView: LoginView!
    private var userModel: UserLogin?

    
    var userID = ""
    var username = ""
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView()
        loginView.frame = view.bounds
        loginView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(loginView)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.loginButtonTest.addTarget(self, action: #selector(testUserModel), for: .touchUpInside)
    }
    
    // MARK: - Ação do Botão
    @objc private func loginButtonTapped() {
        print("Botão de login pressionado")
        loginRequest()
        print(username, userID, token)
        
    }
    
    @objc private func testUserModel() {
        print("test pressed")
        if let user = userModel {
            print("test username: \(user.username)")
            print("test token: \(user.token)")
            print("test id: \(user.userID)")
            print("test sucess: \(user.sucesso)")
        }
    }
    
    //MARK: - net func
    
    func loginRequest() {
        let url = URL(string: "https://app.norf.com.br/api/login.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = [
            "user": "Luana@tst.com.br",
            "password": "102030"
        ]
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
                
                let cleanedData = self.removeBOM(from: data)
                
                do {
                    let user = try JSONDecoder().decode(UserLogin.self, from: cleanedData)
                    
                    self.userModel = user
                    
                    DispatchQueue.main.async {
                        print("Login bem-sucedido!")
                        print("User ID: \(user.userID)")
                        print("Nome: \(user.username)")
                        print("Token: \(user.token)")
                        
                        // navegação para outra tela
                        // let homeViewController = HomeViewController()
                        // self.navigationController?.pushViewController(homeViewController, animated: true)
                    }
                } catch {
                    print("Erro ao processar o JSON: \(error.localizedDescription)")
                    if let rawResponse = String(data: cleanedData, encoding: .utf8) {
                        print("Resposta bruta ao falhar na decodificação: \(rawResponse)")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    
    
        func removeBOM(from data: Data) -> Data {
        var cleanedData = data
        if cleanedData.count > 3 && cleanedData[0] == 0xEF && cleanedData[1] == 0xBB && cleanedData[2] == 0xBF {
            cleanedData.removeSubrange(0..<3)
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
        case username = "Nome"
        case token = "Token"
        case userID = "UserID"
    }
}
