const std = @import("std");
const C = @import("class.zig").Class;
const class = @import("class.zig").classes;
const P = @import("player.zig").Player;
const PL = @import("map.zig").Place;
const M = @import("monster.zig").Monster;
const W = @import("world.zig").World;

const util = @import("util.zig");

const dev = true;

// const clas = enum {
//     Wiroe,
//     Wizre,
//     Rouge,
// };

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    if (dev) {
        const stdout = std.io.getStdOut().writer(); // std
        //
        var world = try W.init(&allocator, 10);
        defer world.deinit();
        //
        while (true) {
            try stdout.print("1) create a new avntur\n", .{});
            try stdout.print("2) load a old avntur\n", .{});
            try stdout.print(":", .{});
            const pick = try util.Input(allocator);
            // defer allocator.free(cho);
            const pk = std.fmt.parseInt(u8, pick, 10) catch 0;
            allocator.free(pick);

            switch (pk) {
                1 => { // create new avatur
                    try stdout.print("Pick a class\n", .{});
                    for (class, 0..) |value, i| {
                        try stdout.print("{d}) {s}\n", .{ i, value.name });
                    }
                    try stdout.print(":", .{});
                    const clas = try util.Input(allocator);
                    const class_id = std.fmt.parseInt(u8, clas, 10) catch 0;
                    try stdout.print("what is your name gona be?\n", .{});
                    try stdout.print(":", .{});
                    const name = try util.Input(allocator);
                    _ = .{class_id};
                    world.initPlayer(name); // add class
                    break;
                },
                2 => {}, // load save
                3 => {},
                else => continue,
            }
        }

        try stdout.print("Wellcome {s}\n", .{world.player.?.name});

        // var world = try W.init(&allocator, 10);
        // defer world.deinit();

        var i: u8 = 0;
        var mobsGen: bool = false;
        try world.generatePlaces(10);
        while (true) : (i += 1) {
            if (!mobsGen) {
                try world.player.?.curent_postion.?.generateMobs(&allocator, 4);
                mobsGen = true;
            }

            try stdout.print("1) explore the suwrading\n", .{});
            try stdout.print("2) check for moster types\n", .{});
            try stdout.print("", .{});

            try stdout.print(":", .{});
            const cho = try util.Input(allocator);
            // defer allocator.free(cho);
            const guess = std.fmt.parseInt(u8, cho, 10) catch 0;
            allocator.free(cho);

            if (i == 10) {
                try stdout.print("\x1B[2J\x1B[H", .{});
                i = 0;
            }
            switch (guess) {
                1 => std.debug.print("1\n", .{}),
                2 => {
                    for (world.player.?.curent_postion.?.spawnC) |value| {
                        try stdout.print("is looks like {s} is in the {s}\n", .{ value.monster.name, world.player.?.curent_postion.?.name });
                    }
                },
                3 => std.debug.print("3\n", .{}),
                4 => std.debug.print("4\n", .{}),
                5 => std.debug.print("5\n", .{}),
                6 => std.debug.print("6\n", .{}),
                7 => std.debug.print("7\n", .{}),
                else => std.debug.print("GG fail\n", .{}),
            }
            // if (guess == 1) {
            //     std.debug.print("lol ez\n", .{});
            // } else if (guess == 0) {
            //     try stdout.print("\x1B[2J\x1B[H", .{});
            //     try stdout.print("needs to be a number avantur!!!\n", .{});
            // } else {
            //     std.debug.print("{d}\n", .{guess});
            // }
        }
    } else {
        var world = try W.init(&allocator, 10);
        defer world.deinit();

        world.initPlayer("kronborg");

        // const player = try allocator.create(P);
        // errdefer allocator.destroy(player);

        // player.* = P.init("Kronborg"); // Initialize the player instance
        // world.addPlayer(player);

        std.debug.print("player name: {s}\n", .{world.player.?.name});

        try world.generatePlaces(10);
        // for (world.places.?) |value| {
        //     std.debug.print("Placename: {s}\n", .{value.name});
        //     // if (value.spawnC) |spawn| {
        //     //     std.debug.print("SPAWN: {any}\n", .{spawn});
        //     // }
        //     // for (value.spawnC.?) |v| {
        //     //     std.debug.print("can spawn: {any}\n", .{v});
        //     // }
        // }
        // std.debug.print("Player Start place is: {s}\n", .{world.player.?.curent_postion.?.name});
        // try world.travel();
        // std.debug.print("from main: {any}\n", .{world.player.?.curent_postion.?.spawnC});
        try world.player.?.curent_postion.?.generateMobs(&allocator, 4);
        defer allocator.free(world.player.?.curent_postion.?.monsters.?);
        // std.debug.print("Player Start place is: {s}\n", .{world.player.?.curent_postion.?.name});

        std.debug.print("legth: {any}\n", .{world.player.?.curent_postion.?.monsters.?.len});
        std.debug.print("Monster[0].name: {s}\n", .{world.player.?.curent_postion.?.monsters.?[0].name});
        std.debug.print("Monster[1].name: {s}\n", .{world.player.?.curent_postion.?.monsters.?[1].name});
        std.debug.print("Monster[2].name: {s}\n", .{world.player.?.curent_postion.?.monsters.?[2].name});
        std.debug.print("Monster[3].name: {s}\n", .{world.player.?.curent_postion.?.monsters.?[3].name});
        // for (world.player.?.curent_postion.?.monsters.?) |value| {
        //     std.debug.print("this Monster is here: {any}\n", .{value.name});
        // }

        // const random = try util.Random();
        // std.debug.print("{}\n", .{try util.Random(12)});
        // std.debug.print("{}\n", .{try util.Random(5)});
        // const foo = random.intRangeAtMost(u8, 0, 10);;

        // std.debug.print("this is a random u8 betwen 0 and 10 {}\n", .{foo});
    }
}

test "generate Mobs" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var world = try W.init(&allocator, 10);
    defer world.deinit(); // Ensure the world is deinitialized
    world.initPlayer("kronborg");
    try world.generatePlaces(10);
    try world.player.?.curent_postion.?.generateMobs(&allocator, 4);

    try std.testing.expect(world.player.?.curent_postion.?.monsters != null);
}
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
    try world.generatePlaces(2);

    try std.testing.expect(world.player.?.curent_postion != null);
    const old_name = world.player.?.curent_postion.?.name;

    try world.travel();
    try std.testing.expect(!std.mem.eql(u8, world.player.?.curent_postion.?.name, old_name));

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

// pub fn main() !void {
//     var gpa = std.heap.GeneralPurposeAllocator(.{}){};
//     const allocator = gpa.allocator();
//     // std.debug.print("After deinit on Monster's name: {any}\n", .{monster.name});
//     const stdout = std.io.getStdOut().writer();
//     // try stdout.print("Wellcome Avantur to the world of ziks \n 1) create a new Avatu\n 2) join a old Avatur\n:: ", .{});
//     var i: u8 = 0;
//     while (true) : (i += 1) {
//         const cho = try util.Input(allocator);
//         // defer allocator.free(cho);
//         const guess = std.fmt.parseInt(u8, cho, 10) catch 0;
//         allocator.free(cho);

//         if (i == 10) {
//             try stdout.print("\x1B[2J\x1B[H", .{});
//             i = 0;
//         }
//         if (guess == 1) {
//             std.debug.print("lol ez\n", .{});
//         } else if (guess == 0) {
//             try stdout.print("\x1B[2J\x1B[H", .{});
//             try stdout.print("needs to be a number avantur!!!\n", .{});
//         } else {
//             std.debug.print("{d}\n", .{guess});
//         }
//     }
//     try stdout.print("FAILLLL", .{});
// }

// const class = C.init();
// var user = P.init("Mikkel", class);
// std.debug.print("name is: {s}\n", .{user.name});
// try stdout.print("change your name: ", .{});
// const name = try Input();
// try user.ChageMe(name);
// std.debug.print("new name is: {s}\n", .{user.name});
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
// };
