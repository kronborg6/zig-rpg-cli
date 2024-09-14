const std = @import("std");
const Places = @import("./map.zig").Place;
const Class = @import("./class.zig").Class;
const Player = @import("./player.zig").Player;
const Spc = @import("./map.zig").SpawnCance;
const Monster = @import("./monster.zig").Monster;

const util = @import("../util.zig");

const Allocator = std.mem.Allocator;

// TODO: make a % chance for what places are picked
//
// Subject To Change when player need to travler to the next we get 3 random place from a combin list of city and otherPlaces
// need to check for reapt maby mak a list frist

pub const World = struct {
    places: ?[]Places,
    player: ?[]Player,
    allocator: *Allocator,

    pub fn init(allocator: *std.mem.Allocator, places_count: usize, player_count: usize) !World {
        const places = try allocator.alloc(Places, places_count);
        errdefer allocator.free(places);
        const players = try allocator.alloc(Player, player_count);
        errdefer allocator.free(players);

        // const player = try allocator.create(Player);
        // errdefer allocator.destroy(player);

        return World{
            .places = places,
            // .player = null,
            .player = players,
            .allocator = allocator,
        };
    }

    pub fn addPlayers(self: *World, player_count: usize) void {
        _ = .{player_count};
        const players = try self.allocator.alloc(Player, player_count);
        errdefer self.allocator.free(players);
        self.player = players;
    }
    pub fn initPlayer(self: *World, name: []const u8, class: Class) void {
        self.player.?.* = .{ .name = name, .curent_postion = null, .class = class };
    }
    pub fn Test(self: *World) void {
        self.allocator.destroy(self.player.?);
    }
    // TODO: need to paceds places from main func where we need to create them
    pub fn generatePlaces(self: World, places_cout: u8) !void {
        // need to add a % for echace place and max cout for som
        for (places_cout, 0..) |_, i| {
            if (i == 0) self.places.?[i] = city[0] else if (i == 9) self.places.?[i] = city[1] else self.places.?[i] = otherPlaces[try util.Random(6)];
        }
        self.player.?.curent_postion = &self.places.?[0];
    }
    pub fn travel(self: *World) !void {
        const length: u8 = @intCast(self.places.?.len - 1);
        // const all = city ++ otherPlaces;
        var random = [3]u8{
            try util.Random(length),
            try util.Random(length),
            try util.Random(length),
        };
        var i: u8 = 0;
        while (i < 3) : (i += 1) {
            if (random[0] == random[1]) {
                random[0] = try util.Random(length);
            }
            if (random[0] == random[2]) {
                random[0] = try util.Random(length);
            }
            if (random[1] == random[2]) {
                random[1] = try util.Random(length);
            }
        }

        const old = self.player.?.curent_postion.?.name;
        while (true) {
            if (std.mem.eql(u8, old, self.player.?.curent_postion.?.name)) {
                self.player.?.curent_postion.? = &self.places.?[try util.Random(length)];
            } else {
                break;
            }
        }

        // self.player.?.curent_postion.? = &self.places.?[try util.Random(length)];
    }

    pub fn de(self: World) void {
        const allocator = self.allocator;
        allocator.free(self.places.?);
    }

    pub fn deinit(self: *World) void {
        if (self.player) |player| {
            self.allocator.free(player);
        }
        if (self.places) |places| {
            self.allocator.free(places);
        }
    }
};

const Starter = Places{ .name = "Starter" };

const cityNew = [_]Places{
    Places{
        .name = "FooTown1234",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 20 },
            },
            .{
                .monster = Monster{ .name = "Skeleton" },
                .procent = [2]u32{ 5000, 10000 },
            },
        },
    },
    Places{
        .name = "ZooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "BooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "SooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
};

const otherPlacesNew = [_]Places{
    Places{
        .name = "Small forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Big forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Dark forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Dark forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Small Cave",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Big Cave",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Dark Cave",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
};
const city = [_]Places{
    Places{
        .name = "FooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 4997 },
            },
            .{
                .monster = Monster{ .name = "Dragon" },
                .procent = [2]u32{ 4998, 5002 },
            },
            .{
                .monster = Monster{ .name = "Skeleton" },
                .procent = [2]u32{ 5003, 10000 },
            },
        },
    },
    Places{
        .name = "ZooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "BooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "SooTown",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
};

const otherPlaces = [_]Places{
    Places{
        .name = "Small forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Big forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Dark forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Dark forvest",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Small Cave",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Big Cave",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
    Places{
        .name = "Dark Cave",
        .spawnC = &[_]Spc{
            .{
                .monster = Monster{ .name = "Zombie" },
                .procent = [2]u32{ 0, 10000 },
            },
        },
    },
};
// const testing = std.testing;
// test "IntWorld: add"
