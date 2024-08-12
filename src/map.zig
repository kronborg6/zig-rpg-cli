const std = @import("std");
const Monster = @import("monster.zig").Monster;

const Allocator = std.mem.Allocator;

pub const Place = struct {
    // const self = @This();
    name: []const u8,
    // minLvl: u8,
    // maxLvl: u8,
    // // mapType: []const u8,
    // monsters: ?[]Monster,
    // spawnC: []SpawnCance,
    // allocator: Allocator,

    pub fn init(allocator: Allocator, spawn_change_cout: usize, monsters_cout: usize, name: []const u8) !Place {
        const spawn_changes = try allocator.alloc([]SpawnCance, spawn_change_cout);
        errdefer allocator.free(spawn_changes);
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
    monsters: []Monster,
    procent: u32,
    place: Place,
};
