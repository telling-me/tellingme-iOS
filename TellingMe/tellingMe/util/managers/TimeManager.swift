//
//  TimeManager.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/25.
//

import UIKit

final class TimeManager {
    static let shared = TimeManager()
    private init() {}
    
    func shouldRefreshQuestion() -> Bool {
        let currentDate = Date()
        let userDefaults = UserDefaults.standard
        
        let todayRefreshTime = getRefreshTime(nowTime: currentDate)
        
        // Check if the current date is later than today at 6 am
        if currentDate >= todayRefreshTime {
            // Check if the last refresh date is earlier than today at 6 am
            if let lastRefreshDate = userDefaults.object(forKey: StringLiterals.lastQuestionRefreshTime) as? Date {
                if lastRefreshDate < todayRefreshTime {
                    // Update the last refresh date to the current date
                    userDefaults.set(currentDate, forKey: StringLiterals.lastQuestionRefreshTime)
                    return true
                }
            } else {
                // If no last refresh date is stored, set it to the current date
                userDefaults.set(currentDate, forKey: StringLiterals.lastQuestionRefreshTime)
                return true
            }
        }
        return false
    }
    
    private func getRefreshTime(nowTime now: Date) -> Date {
        let calendar = Calendar.current
        var refreshComponents = calendar.dateComponents([.year, .month, .day], from: now)
        refreshComponents.hour = 6
        refreshComponents.minute = 0
        refreshComponents.second = 0
        
        guard let todayRefreshTime = calendar.date(from: refreshComponents) else { return Date() }
        return todayRefreshTime
    }
}

//// MARK: - 서버시간 활용해서 이 사람이 시간을 수동을 만지는지 확인하기
//// 그래야 시간을 앞으로 돌려서 질문 확인 못하지.
//
//func fetchExternalTime(completion: @escaping (Date?) -> Void) {
//    guard let url = URL(string: "https://your-time-server-url-here.com") else {
//        completion(nil)
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
//        if let error = error {
//            print("Error fetching external time: \(error.localizedDescription)")
//            completion(nil)
//            return
//        }
//
//        if let data = data,
//           let externalTime = parseTimeFromData(data) {
//            completion(externalTime)
//        } else {
//            completion(nil)
//        }
//    }
//
//    task.resume()
//}
//
//func parseTimeFromData(_ data: Data) -> Date? {
//    // Parse the external time from the data (format depends on the time server)
//    // Return nil if parsing fails
//    return nil
//}
