import XCTest
@testable import MyLibrary
// import WeatherService

final class MyLibraryTests: XCTestCase {

    func testifWeatherDataProtocalWorks() async {
        // Given
        struct Information: Decodable {
            let name: String
            }
        let informationData = """
        {
        "coord": {
        "lon": 123.26,
        "lat": 44.56
        },
        "weather": [
        {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
        }
        ],
        "base": "stations",
        "main": {
        "temp": 295.29,
        "feels_like": 294.47,
        "temp_min": 295.29,
        "temp_max": 295.29,
        "pressure": 1009,
        "humidity": 35,
        "sea_level": 1009,
        "grnd_level": 992
        },
        "visibility": 10000,
        "wind": {
        "speed": 5.48,
        "deg": 32,
        "gust": 5.65
        },
        "clouds": {
        "all": 17
        },
        "dt": 1664343405,
        "sys": {
        "country": "CN",
        "sunrise": 1664314826,
        "sunset": 1664357704
        },
        "timezone": 28800,
        "id": 2036338,
        "name": "Kaitong"
    }
    """.data(using: .utf8)!

        let decoder = JSONDecoder()
        // when
        let information = try! decoder.decode(Weather.self, from: informationData)
        // Then
        XCTAssertNotNil(information.main.temp)
        XCTAssert(information.main.temp == 295.29)
    }


    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }

}
