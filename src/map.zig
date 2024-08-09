const std = @import("std");
const m = @import("monster.zig").Monster;

pub const Place = struct {
    const self = @This();
    name: []const u8,
    minLvl: u8,
    maxLvl: u8,
    mapType: []const u8,
    monsters: []m.Monster,

    pub fn init() self {
        return self{
            .name = "Lol",
            .minLvl = 1,
            .maxLvl = 10,
            .mapType = "City",
            .monsters = [_]m.Monster{
                .{
                    .name = "Rat",
                },
                .{
                    .name = "Fly",
                },
            },
        };
    }
};
