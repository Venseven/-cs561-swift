import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum BaseUrl :String {
    case realapi = "https://api.openweathermap.org/data/2.5/weather"
    case moclserver = "http://localhost:3000/data/2.5/weather"
}
class WeatherServiceImpl: WeatherService {
    // case switch between realAPI and MockServer
    // let url = "\(BaseUrl.moclserver)?lat=44.56&lon=123.26&appid=d8310c9fbcfaee650d22017af4646e00" 
    let url =  "http://0.0.0.0:8080/data/2.5/weather"
    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}

