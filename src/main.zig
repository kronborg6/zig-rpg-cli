const std = @import("std");
const C = @import("class.zig").Class;
const P = @import("player.zig").Player;

pub fn main() !void {
    const class = C.init();
    var user = P.init("Mikkel", class);
    std.debug.print("name is: {s}\n", .{user.name});
    // defer user.End();
    // defer user.allocator.free(std.mem.Allocator);
    // defer std.heap.page_allocator.free(user);

    // user.GetName();
    // std.debug.print("new name is: ", .{});
    // const new = std.io.getStdIn().reader();

    // std.debug.print("New Name is: {any}\n", .{new});
    // std.debug.print("Get class name via Player: {s}\n", .{user.GetClassName()});
    // std.debug.print("Get class name via Player.class: {s}\n", .{user.class.GetClassName()});
    std.debug.print("change name: ", .{});
    const name = try Input();
    try user.ChageMe(name);
    // std.heap.page_allocator.free(name);
    std.debug.print("new name is: {s}\n", .{user.name});

    // std.debug.print("line: {s}\n", .{newName});
}

fn Input() ![]const u8 {
    const stdin = std.io.getStdIn().reader();

    const bare_line = try stdin.readUntilDelimiterAlloc(
        std.heap.page_allocator,
        '\n',
        8192,
    );
    const gg = std.mem.trim(u8, bare_line, "\r");
    // defer std.heap.page_allocator.free(bare_line);
    // std.debug.print("{s}\n", .{gg});
    return gg;
}
