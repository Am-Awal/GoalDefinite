//
//  GoalMove.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct GoalMove: Identifiable {
    let id = UUID()
    var description: String
    var rank: Int
    var executionStart: String
    var executionEnd: String
}

var goalMoves = [
    GoalMove(description: "Leo duis ut diam quam nulla porttitor. Consectetur lorem donec massa sapien faucibus et. Id ornare arcu odio ut sem nulla pharetra diam.", rank: 1, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Varius morbi enim nunc faucibus a pellentesque sit amet. Commodo quis imperdiet massa tincidunt nunc pulvinar sapien et ligula.", rank: 2, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Vel facilisis volutpat est velit egestas dui. Enim blandit volutpat maecenas volutpat blandit.", rank: 3, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Iaculis eu non diam phasellus vestibulum lorem sed.", rank: 1, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Molestie a iaculis at erat pellentesque adipiscing commodo. Hac habitasse platea dictumst quisque sagittis. Nisl purus in mollis nunc.", rank: 2, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Build an iOS app for iOS 15 with custom layouts...", rank: 3, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Ac placerat vestibulum lectus mauris ultrices eros in cursus. Urna molestie at elementum eu facilisis sed odio morbi.", rank: 1, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Mi ipsum faucibus vitae aliquet nec ullamcorper. Ipsum a arcu cursus vitae congue. Placerat vestibulum lectus mauris ultrices eros in cursus turpis massa.", rank: 2, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Pretium viverra suspendisse potenti nullam ac tortor. Tempus urna et pharetra pharetra massa.", rank: 3, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Suspendisse faucibus interdum posuere lorem ipsum dolor. Habitant morbi tristique senectus et netus et malesuada fames.", rank: 1, executionStart: "Now", executionEnd: "Now"),
    GoalMove(description: "Convallis convallis tellus id interdum velit laoreet id donec. Nulla posuere sollicitudin aliquam ultrices.", rank: 2, executionStart: "Now", executionEnd: "Now")
]
