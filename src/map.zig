const std = @import("std");
const utl = @import("util.zig");
const Monster = @import("monster.zig").Monster;

const Allocator = std.mem.Allocator;

pub const Place = struct {
    // const self = @This();
    name: []const u8,
    // minLvl: u8,
    // maxLvl: u8,
    // // mapType: []const u8,
    // monsters: ?[]Monster,
    spawnC: ?[]const SpawnCance = null,
    // allocator: Allocator,

    pub fn init(allocator: Allocator, spawn_changes: []SpawnCance, monsters_cout: usize, name: []const u8) !Place {
        // const spawn_changes = try allocator.alloc([]SpawnCance, spawn_change_cout);
        // errdefer allocator.free(spawn_changes);
        const monsters = try allocator.alloc([]Monster, monsters_cout);
        errdefer allocator.free(monsters);

        return .{
            .name = name,
            .minLvl = 1,
            .maxLvl = 10,
            .monsters = monsters,
            .spawnC = spawn_changes,
            .allocator = allocator,
        };
    }
    pub fn generateMobs(self: *Place, cout: u8) void {
        // for (cout, 0..) |_, i| {

        // }
        _ = .{ self, cout };
    }

    // pub fn init() self {
    //     return self{
    //         .name = "Lol",
    //         .minLvl = 1,
    //         .maxLvl = 10,
    //         .mapType = "City",
    //         .monsters = [_]m.Monster{
    //             .{
    //                 .name = "Rat",
    //             },
    //             .{
    //                 .name = "Fly",
    //             },
    //         },
    //     };
    // }
};
pub const SpawnCance = struct {
    monster: Monster,
    procent: [2]u32,
    // place: Place,
};

//
const spawns = [_]SpawnCance{
    .{
        .monster = Monster{
            .name = "Zombie",
        },
        .procent = [2]u32{ 0, 3333 },
    },
    .{
        .monster = Monster{
            .name = "Skeleton",
        },
        .procent = [2]u32{ 3334, 5000 },
    },
    .{
        .monster = Monster{
            .name = "Slim",
        },
        .procent = [2]u32{ 5001, 9989 },
    },
    .{
        .monster = Monster{
            .name = "Dragon",
        },
        .procent = [2]u32{ 9990, 10000 },
    },
};
