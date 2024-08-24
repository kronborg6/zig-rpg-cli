const std = @import("std");
const Monster = @import("monster.zig").Monster;
const Class = @import("class.zig").Class;
const Place = @import("map.zig").Place;
pub const Player = struct {
    const self = @This();
    name: []const u8,
    curent_postion: ?*Place,
    // hp: i16,
    // mp: i16,
    // lvl: u8,
    // xp: u16,
    class: Class,

    pub fn init(name: []const u8) self {
        return self{
            .name = name,
            .curent_postion = null,
            // .hp = 100,
            // .mp = 50,
            // .lvl = 1,
            // .xp = 0,
            // .class = class,
        };
    }
    pub fn GetName(me: self) void {
        std.debug.print("my name is: {s}\n", .{me.name});
    }

    pub fn ChageMe(me: *self, NewName: []const u8) !void {
        me.name = NewName;
    }
    pub fn GetClassName(me: self) []const u8 {
        return me.class.name;
    }

    pub fn Attact(me: *self, monster: *Monster) void {
        monster.name = "Kronborg er gud";
        _ = .{ me, monster };
    }
    // pub fn End(me: self) void {
    //     me.allocator.free(me);
    // }
};
