//
//  ViewController2.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 7/2/21.
//

import UIKit
import Alamofire

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        getUpcomingMovieList()
//        getGenresList()
        initLogin()
        
    }
    

    private func getUpcomingMovieList(){
        /*
         1. url
         2. method
         3. headers
         4. body
         */
        
        let url = "\(AppConstantsBaseURL)/movie/upcoming?.api_key=\(AppConstantsapiKey)"
        
        AF.request(url)
            
//            .response { (response) in
//            debugPrint(response)
//          }
//            .responseString { (response) in
//                debugPrint(response.value!)
//            }
    
        
      .responseDecodable(of: UpcomingMoiveList.self) { response in
        // AFDataResopnse<UpcomingMovieList>
        switch response.result{
        case .success(let upcomingMovieList ):
            debugPrint("Upcoming Movies: ")
            upcomingMovieList.results?.forEach{
                debugPrint($0.originalTitle!)
            }
            
        case .failure(let error):
            debugPrint(error.errorDescription!)
        }
        
        }
        
        
        
    }
    
    private func getGenresList(){
        
        let url = "\(AppConstantsBaseURL)/genre/movie/list?api_key=\(AppConstantsapiKey)"
        AF.request(url)
            
            .responseDecodable(of: MovieGenreList.self) { response in
              // AFDataResopnse<UpcomingMovieList>
              switch response.result{
              case .success(let data ):
                  debugPrint("MovieGenreLists: ")
                data.genres.forEach{
                      debugPrint($0.name)
                  }
                  
              case .failure(let error):
                  debugPrint(error.errorDescription!)
              }
              
              }
    }
    
    
    
    private func initLogin(){
        
        let url = "\(AppConstantsBaseURL)/authentication/token/new?api_key=\(AppConstantsapiKey)"
        AF.request(url)
            .responseDecodable(of: LoginReqeust.self){ response in
                switch response.result{
                case .success(let data ):
                    let requestToken = data.reqeustToken
                    self.login(requestToken)
                case .failure(let error):
                    debugPrint(error)
                }
                
            }
    }
    
    
    private func login(_ requestToken : String){
        
        //url
        let url = "\(AppConstantsBaseURL)/authentication/token/validate_with_login?api_key=\(AppConstantsapiKey)"
        
        //body
        let requestObject = LoginReqeust(username: moiveDbUserName , password: moiveDbPassword, reqeustToken: requestToken)
        

        AF.request(url, method: .post, parameters: requestObject)
            
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginSuccess.self) { response in
              // AFDataResopnse<UpcomingMovieList>
              switch response.result{
              case .success(let data ):
                print("Token Status: ", data.success ?? false)
              case .failure(let error):
                  debugPrint(error.errorDescription!)
              }
              
              }
        
    }
   
    private func searchMovies(name: String){
        
        
        
    }
    
    
}
