//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 6/26/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=9a86d2ae7b1cd3a67291cb0c6070ac90")!
        
        
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
            let dataDict = try! JSONSerialization.jsonObject(with: data!, options: .init()) as! [String:Any]
            let genreList = dataDict["genres"] as! [[String:Any]]
          moiveGenres = genreList.map { genre -> MoiveGenre in
                
                let id = genre["id"] as! Int
                let name = genre["name"] as! String
                return MoiveGenre(id: id, name: name)
            }
            
            print(moiveGenres.count)
            
        }.resume()
        
    }
}

struct MoiveGenre {
    let id : Int
    let name : String
}

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

