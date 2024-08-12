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

        const player = try allocator.create(Player);
        errdefer allocator.destroy(player);

        return World{
            .places = places,
            .player = player,
            .allocator = allocator,
        };
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
