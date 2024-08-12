const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Monster = struct {
    const self = @This();
    name: []const u8,
    // lvl: u8,
    // minDamage: u16,
    // maxDamage: u16,
    // allocator: Allocator,

    pub fn init(name: []const u8) self {
        return self{
            .name = name,
        };
    }

    pub fn deinit(s: self) void {
        s.allocator.free(s.name);
    }
};
