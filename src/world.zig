const std = @import("std");
const Places = @import("map.zig").Place;
const Player = @import("player.zig").Player;

const util = @import("util.zig");

const Allocator = std.mem.Allocator;

// TODO: make a % chance for what places are picked

const Starter = Places{ .name = "Starter" };

const city = [_]Places{
    Places{ .name = "FooTown" },
    Places{ .name = "ZooTown" },
    Places{ .name = "BooTown" },
    Places{ .name = "SooTown" },
};

const otherPlaces = [_]Places{
    Places{ .name = "Small forvest" },
    Places{ .name = "Big forvest" },
    Places{ .name = "Dark forvest" },
    Places{ .name = "Dark forvest" },
    Places{ .name = "Small Cave" },
    Places{ .name = "Big Cave" },
    Places{ .name = "Dark Cave" },
};

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
            // .player = null,
            .player = player,
            .allocator = allocator,
        };
    }

    pub fn addPlayer(self: *World, player: *Player) void {
        self.player = player;
    }
    pub fn initPlayer(self: *World, name: []const u8) void {
        self.player.?.* = .{ .name = name, .curent_postion = null };
    }
    pub fn Test(self: *World) void {
        self.allocator.destroy(self.player.?);
    }
    pub fn generatePlaces(self: World, places_cout: u8) !void {
        // need to add a % for echace place and max cout for som
        for (places_cout, 0..) |_, i| {
            if (i == 0) self.places.?[i] = city[0] else if (i == 9) self.places.?[i] = city[1] else self.places.?[i] = otherPlaces[try util.Random(6)];
        }
        self.player.?.curent_postion = &self.places.?[0];
    }

    pub fn de(self: World) void {
        const allocator = self.allocator;
        allocator.free(self.places.?);
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
