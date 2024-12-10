//
//  MotivationalMessage.swift
//  MVVMToDoSwiftUI
//
//  Created by Doğukan Sakin on 10.12.2024.
//

enum MotivationalMessage:String.LocalizationValue,CaseIterable {
    case startYourDay = "start_your_day_message"
    case keepGoing = "keep_going_message"
    case stayOnTrack = "stay_on_track_message"
    case achieveGoals = "achieve_goals_message"
    case endOfDay = "end_of_day_message"
    case neverStop = "never_stop_message"
    case finishStrong = "finish_strong_message"
    case todayIsYourDay = "today_is_your_day_message"
    case keepMoving = "keep_moving_message"
    case stayPositive = "stay_positive_message"
    
    static func getRandomMessage()->String.LocalizationValue {
        return MotivationalMessage.allCases.randomElement()!.rawValue
    }
}
