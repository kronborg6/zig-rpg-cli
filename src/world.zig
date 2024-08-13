const std = @import("std");
const Places = @import("map.zig").Place;
const Player = @import("player.zig").Player;
const Allocator = std.mem.Allocator;

pub const World = struct {
    places: ?[]Places,
    player: ?*Player,
    allocator: *Allocator,

    pub fn init(allocator: *std.mem.Allocator, places_count: usize) !World {
        const places = try allocator.alloc(Places, places_count);
        errdefer allocator.free(places);

        // const player = try allocator.create(Player);
        // errdefer allocator.destroy(player);

        return World{
            .places = places,
            .player = null,
            .allocator = allocator,
        };
    }

    pub fn addPlayer(self: *World, player: *Player) void {
        self.player = player;
    }
    pub fn Test(self: *World) void {
        self.allocator.destroy(self.player.?);
    }

    pub fn deinit(self: *World) void {
        if (self.player) |player| {
            self.allocator.destroy(player);
        }
        if (self.places) |places| {
            self.allocator.free(places);
        }
    }
};

// const testing = std.testing;
// test "IntWorld: add"
