const std = @import("std");
const C = @import("class.zig").Class;
const P = @import("player.zig").Player;
const PL = @import("map.zig").Place;
const M = @import("monster.zig").Monster;
const W = @import("world.zig").World;

const util = @import("util.zig");

// pub fn main() !void {
//     var gpa = std.heap.GeneralPurposeAllocator(.{}){};
//     var allocator = gpa.allocator();
//     var world = try W.init(&allocator, 10);
//     defer world.deinit();

//     world.initPlayer("kronborg");

//     // const player = try allocator.create(P);
//     // errdefer allocator.destroy(player);

//     // player.* = P.init("Kronborg"); // Initialize the player instance
//     // world.addPlayer(player);

//     std.debug.print("player name: {s}\n", .{world.player.?.name});

//     try world.generatePlaces(10);
//     for (world.places.?) |value| {
//         std.debug.print("Placename: {s}\n", .{value.name});
//     }
//     std.debug.print("Player Start place is: {s}\n", .{world.player.?.curent_postion.?.name});
//     try world.travel();
//     std.debug.print("Player Start place is: {s}\n", .{world.player.?.curent_postion.?.name});

//     // const random = try util.Random();
//     // std.debug.print("{}\n", .{try util.Random(12)});
//     // std.debug.print("{}\n", .{try util.Random(5)});
//     // const foo = random.intRangeAtMost(u8, 0, 10);

//     // std.debug.print("this is a random u8 betwen 0 and 10 {}\n", .{foo});
// }
test "World and Player memory management test" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    // defer gpa.deinit(); // Ensure the allocator is properly deinitialized.

    // Step 1: Initialize the World
    var world = try W.init(&allocator, 10);
    defer world.deinit(); // Ensure the world is deinitialized

    // // Step 2: Create and add a Player to the World
    // const player = try allocator.create(P);
    // errdefer allocator.destroy(player);

    // player.* = P.init("TestPlayer"); // Initialize the player instance
    world.initPlayer("TestPlayer");

    try world.generatePlaces(1);

    // Step 3: Check if the player is correctly added to the world
    try std.testing.expect(world.player != null);
    try std.testing.expectEqualStrings("TestPlayer", world.player.?.name);
    try std.testing.expect(world.places != null);
    try std.testing.expectEqualStrings("FooTown", world.player.?.curent_postion.?.name);

    // Additional assertions can be added here if needed
}
test "World Travel" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    var world = try W.init(&allocator, 10);
    defer world.deinit(); // Ensure the world is deinitialized

    world.initPlayer("TestPlayer");

    // const old_name = world.player.?.curent_postion.?.name;
    try world.travel();

    // try std.testing.Str
}

// pub fn main() !void {
//     const number = try util.RandomT(u32, 10000);

//     std.debug.print("{d}\n", .{number});
// }

// LOL

// Example: Access player and places.
// if (world.player) |player| {
//     player.name = "Hero";
//     std.debug.print("Player Name: {s}\n", .{player.name});
// }

// if (world.places) |places| {
//     // Example: Initialize a place.
//     places[0] = PL{ .name = "Town" };
//     std.debug.print("First Place Name: {s}\n", .{places[0].name});
// }

// Additional game logic here...

// Memory cleanup is handled by the defer statement.
// var gpa = std.heap.GeneralPurposeAllocator(.{}){};
// const allocator = gpa.allocator();
// var world = try W.init(allocator, 4);
// defer world.deinit();

// std.debug.print("world: {any}", .{world});
// }

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    // std.debug.print("After deinit on Monster's name: {any}\n", .{monster.name});
    const stdout = std.io.getStdOut().writer();
    // try stdout.print("Wellcome Avantur to the world of ziks \n 1) create a new Avatu\n 2) join a old Avatur\n:: ", .{});
    while (true) {
        const cho = try util.Input(allocator);
        defer allocator.free(cho);
        const guess = std.fmt.parseInt(u8, cho, 10) catch 0;

        if (guess == 1) {
            std.debug.print("lol ez\n", .{});
        } else if (guess == 0) {
            try stdout.print("\x1B[2J\x1B[H", .{});
            try stdout.print("needs to be a number avantur!!!\n", .{});
        } else {
            std.debug.print("{d}\n", .{guess});
        }
    }
    //     try stdout.print("FAILLLL", .{});
    // }

    // const class = C.init();
    // var user = P.init("Mikkel", class);
    // std.debug.print("name is: {s}\n", .{user.name});
    // try stdout.print("change your name: ", .{});
    // const name = try Input();
    // try user.ChageMe(name);
    // std.debug.print("new name is: {s}\n", .{user.name});
}

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
