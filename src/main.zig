const std = @import("std");
const C = @import("class.zig").Class;
const P = @import("player.zig").Player;

pub fn main() !void {
    const class = C.init();
    var user = P.init("Mikkel", class);

    user.GetName();

    try user.ChageMe("Kong Kronborg");
    std.debug.print("New Name is: {s}\n", .{user.name});
    std.debug.print("Get class name via Player: {s}\n", .{user.GetClassName()});
    std.debug.print("Get class name via Player.class: {s}\n", .{user.class.GetClassName()});
}
