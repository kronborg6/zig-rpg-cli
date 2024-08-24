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
    monsters: ?[]Monster = null,
    spawnC: []const SpawnCance = undefined,
    allocator: Allocator = undefined,

    pub fn init(allocator: Allocator, monsters_cout: usize, name: []const u8) !Place {
        // const spawn_changes = try allocator.alloc([]SpawnCance, spawn_change_cout);
        // errdefer allocator.free(spawn_changes);
        const monsters = try allocator.alloc([]Monster, monsters_cout);
        errdefer allocator.free(monsters);

        return .{
            .name = name,
            // .minLvl = 1,
            // .maxLvl = 10,
            .monsters = monsters,
            // .spawnC = spawn_changes,
            .allocator = allocator,
        };
    }
    pub fn generateMobs(self: *Place, allocator: *std.mem.Allocator, cout: u8) !void {

        // std.debug.print("lol {any}\n", .{self.spawnC});
        const monsters = try allocator.alloc(Monster, cout);
        errdefer allocator.free(monsters);
        for (cout, 0..) |_, i| {
            const random = try utl.RandomT(u32, 10000);
            // std.debug.print("random is: {d}\n", .{random});
            _ = .{i};

            // std.debug.print("hello: {any}\n", .{self.name});

            for (self.spawnC) |value| {
                if (random >= value.procent[0]) {
                    if (random <= value.procent[1]) {
                        // std.debug.print("YES {s}\n", .{value.monster.name});
                        monsters[i] = value.monster;
                        break;
                    }
                }
            }
            // std.debug.print("GG NT {any}\n", .{self.monsters.?});
            // if (self.monsters) |mon| {
            //     for (mon) |value| {
            //         std.debug.print("They is this Monster here: {s}", .{value.name});
            //     }
            // }
        }
        self.monsters = monsters;
        // if (self.monsters) |m| {
        //     std.debug.print("GG GG GG GG: {any}\n", .{m});
        // }
        // self.allocator = allocator;
        _ = .{ self, cout };
    }

    pub fn deinitMobs(self: *Place) void {
        const allocator = self.allocator;
        allocator.free(self.monsters);
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
