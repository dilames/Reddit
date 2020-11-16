//
//  ChronoService.swift
//  Platform
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Combine
import Domain

final class ChronoService: RedditChronoUseCase {
    
    private let calendar = Calendar.autoupdatingCurrent
    
    private lazy var dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .second, .hour, .minute, .month]
        formatter.maximumUnitCount = 1
        formatter.formattingContext = .listItem
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .default
        formatter.calendar = calendar
        return formatter
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        return formatter
    }()
    
    private var suffix: String {
        return " ago"
    }
    
    private var lessThatSecondAgoPhrase: String {
        return "Less than a second"
    }
    
    private var todayPhrase: String {
        return "Today"
    }
    
    private func string(from reference: Date, to date: Date) -> String? {
        return (reference.timeIntervalSinceNow < -1
            ? dateComponentsFormatter.string(from: reference, to: date)?.components(separatedBy: ",").first
            : lessThatSecondAgoPhrase)?.appending(suffix)
    }
    
}

// MARK: Combine
extension ChronoService {
    
    func dateComponentsPublisher(from sourceDate: Date, interval: TimeInterval) -> AnyPublisher<String?, Never> {
        return Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .merge(with: Just(Date()))
            .compactMap { [weak self] in self?.string(from: sourceDate, to: $0) }
            .eraseToAnyPublisher()
    }
    
}
