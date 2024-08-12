const std = @import("std");
const C = @import("class.zig").Class;
const P = @import("player.zig").Player;
const PL = @import("map.zig").Place;
const M = @import("monster.zig").Monster;
const W = @import("world.zig").World;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    // defer gpa.deinit(); // Ensure the allocator is properly deinitialized.

    // Initialize the world with space for 10 places.
    var world = try W.init(&allocator, 10);
    defer world.deinit();

    // Example: Access player and places.
    if (world.player) |player| {
        player.name = "Hero";
        std.debug.print("Player Name: {s}\n", .{player.name});
    }

    if (world.places) |places| {
        // Example: Initialize a place.
        places[0] = PL{ .name = "Town" };
        std.debug.print("First Place Name: {s}\n", .{places[0].name});
    }

    // Additional game logic here...

    // Memory cleanup is handled by the defer statement.
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    // var world = try W.init(allocator, 4);
    // defer world.deinit();

    // std.debug.print("world: {any}", .{world});
}

// pub fn mainOld() !void {
//     var gpa = std.heap.GeneralPurposeAllocator(.{}){};
//     const allocator = gpa.allocator();
//     const monster = try M.init(allocator, "Goblin");

//     std.debug.print("Monster's name is: {s}\n", .{monster.name});
//     monster.deinit();
//     // std.debug.print("After deinit on Monster's name: {any}\n", .{monster.name});
//     // const stdout = std.io.getStdOut().writer();
//     // try stdout.print("Wellcome Avantur to the world of ziks \n 1) create a new Avatu\n 2) join a old Avatur\n:: ", .{});
//     // const cho = try Input();
//     // const guess = std.fmt.parseInt([]const u8, cho, 10);

//     // if (guess == 1) {
//     //     try stdout.print("1", .{});
//     // }
//     // if (guess == 2) {
//     //     try stdout.print("2 ", .{});
//     // } else {
//     //     try stdout.print("FAILLLL", .{});
//     // }

//     // const class = C.init();
//     // var user = P.init("Mikkel", class);
//     // std.debug.print("name is: {s}\n", .{user.name});
//     // try stdout.print("change your name: ", .{});
//     // const name = try Input();
//     // try user.ChageMe(name);
//     // std.debug.print("new name is: {s}\n", .{user.name});
// }

// fn Input() ![]const u8 {
//     const stdin = std.io.getStdIn().reader();

//     const bare_line = try stdin.readUntilDelimiterAlloc(
//         std.heap.page_allocator,
//         '\n',
//         8192,
//     );
//     const input = std.mem.trim(u8, bare_line, "\r");
//     return input;
// }
