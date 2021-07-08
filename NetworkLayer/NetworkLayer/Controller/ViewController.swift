//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 6/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblGeneral: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        getUpcomingMoiveList()
        
        login()
        getGenresList()
            
}

    // MARK: - UpcomingMovieList // error
    
    private func getUpcomingMoiveList(){

        let url = URL(string: "\(AppConstants.BaseURL)/movie/upcoming?api_key=\(AppConstants.apiKey)")!

//        var urlRequest = URLRequest(url: url)
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let data = data{
//                let upcomingMovieList = try! JSONDecoder().decode(UpcomingMoiveList.self, from : data)
//                DispatchQueue.main.async {
//                    self.lblGeneral.text = upcomingMovieList.results?.map{$0.title ?? "undefined"}.reduce
//                    if value1.isEmpty{
//                        return value2
//                    }else{
//                        return " \(value1),\(value2)"
//                    })
//                }
//            }
            
        var urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data{
                let upcomingMovieList = try! JSONDecoder().decode(UpcomingMoiveList.self, from : data)
                upcomingMovieList.results?.forEach({ (item) in
                    print(item.originalTitle ?? "undefined")
                    })
            }
          
            
//        let upcomingMovieList = try! JSONDecoder().decode(UpcomingMoiveList.self, from : data!)
//        upcomingMovieList.results?.forEach({ (item) in
//            print(item.originalTitle ?? "undefined")
//            })
        }.resume()

    }

    
    
    // MARK: - Login
    
    private func login(){
            
        let url = URL(string: "\(AppConstants.BaseURL)/authentication/token/validate_with_login?api_key=9a86d2ae7b1cd3a67291cb0c6070ac90")!
        
        var urlRequest = URLRequest(url: url)
    
        //Method
        urlRequest.httpMethod = "POST"
        
        //Hearder
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Body
//        let reqeustBody = [
//            "username": "kyawhtetaung",
//            "password": "Toyot@123",
//            "request_token": "25ccc9ffe7f66e5944b0b5fa1da4dd1a5726e63e"
//        ]
//        let bodyData = try! JSONSerialization.data(withJSONObject: reqeustBody, options: .init())
//        urlRequest.httpBody = bodyData
//
        let requestObject = LoginReqeust(username: AppConstants.moiveDbUserName , password: AppConstants.moiveDbPassword, reqeustToken: AppConstants.requestToken)
        let requestData = try! JSONEncoder().encode(requestObject)
        urlRequest.httpBody = requestData
        
        // Network call
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successCodeRange = 200..<300
            let decoder = JSONDecoder()
            if successCodeRange.contains(statusCode){ // success
                let res = try! decoder.decode(LoginSuccess.self, from: data!)
                print(res.success)
                print(res.statusCode)
                print(res.statusMessage)
            } else {
                print(String(data: data!, encoding: .utf8))
                let res = try! decoder.decode(LoginFailed.self, from: data!)
                print(res.success)
                print(res.statusCode)
                print(res.statusMessage)
            }
            
            
//            if successCodeRange.contains(statusCode){   // success
//                print(String(data: data!, encoding: .utf8))
//            }else{ // failure
//                print(String(data: data!, encoding: .utf8))
//            }
        }.resume()
        
}

    // MARK: - getGenresList
    
    private func  getGenresList(){

//    let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=9a86d2ae7b1cd3a67291cb0c6070ac90")!
    
        
        let url = URL(string: "\(AppConstants.BaseURL)/genre/movie/list?api_key=9a86d2ae7b1cd3a67291cb0c6070ac90")!
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"  // case sensitive
    urlRequest.allHTTPHeaderFields = ["key1" : "value1", "key2" : "value2"]
    urlRequest.setValue("value3", forHTTPHeaderField: "key3")
//        urlRequest.httpBody
 
    
    // Default session
    let session = URLSession.shared
//        session.dataTask(with: urlRequest) { data, response, error in
//            print("data \(data)")
//            print("response \(response)")
//            print("error \(error)")
//        }.resume()

//        session.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        
//        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//        session.dataTask(with: url)
//    // completion handler
//        { data, response, error in
//            print("completion handaler called")
//            print("data \(data)")
//            print("response \(response)")
//            print("error \(error)")
//        }.resume()
   
//        နှစ်ခုတူနေရင် ပေါ်ကထဲ(completion handaler) data က default ၀င်လိုဖျက်ပေးမ အောက်ကထဲ၀င်မာ
    
//        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//        session.dataTask(with: url).resume()
    
//        // Response session
    
//        session.dataTask(with: urlRequest) { (data, response, error) in
//            let httpResponse = response as! HTTPURLResponse
//            print(httpResponse.allHeaderFields["Content-Type"])
//        }.resume()
    
    // utf8 နဲ့ utf16 မာပိုလာတာကိုကြည့် မှားနေရင် data မရဘူး
    // map က object array တစ်ခုလုံးကိုပြန်သုံးမာမိုလို / ရှိသမျှ list တေအကုန်လုံးကို loop ပတ်ပေးလိုက်တယ်
    session.dataTask(with: urlRequest) { (data, response, error) in
//            print(String(data: data!, encoding: .utf8))
        
        let genreList : MovieGenreList = try! JSONDecoder().decode(MovieGenreList.self, from: data!)
        
//        let dataDict = try! JSONSerialization.jsonObject(with: data!, options: .init()) as! [String:Any]
//        let genreList = dataDict["genres"] as! [[String:Any]]
//      moiveGenres = genreList.map { genre -> MoiveGenre in
//
//            let id = genre["id"] as! Int
//            let name = genre["name"] as! String
//            return MoiveGenre(id: id, name: name)
//        }
//            print(moiveGenres.count)
//
//        print(genreList.genres.count)

    }.resume()

    }

}

//struct MovieGenreList : Decodable {
//    let genres : [MoiveGenre]
//}
//
//struct MoiveGenre : Decodable{
//    let id : Int
//    let name : String
////    let anotherProperty : String?   // data မပါရင်သုံးဖို
//}

var moiveGenres = [MoiveGenre]()


//delegate နဲ့ခေါ်သုံး ပိုပီး customize လုပ်လိုရသွားတယ်
//extension ViewController : URLSessionDataDelegate{
//
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        print("delegate called")
//        print("error \(error)")
//    }
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        print("delegate called")
//        print("data \(data)")
//    }
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
//        print("delegate called")
//        print("response \(response)")
//        completionHandler(.allow)
//    }
//}

