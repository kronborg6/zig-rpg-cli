const std = @import("std");

pub fn main() void {
    var args = std.process.args();

    var port: []const u8 = undefined;
    var name: []const u8 = undefined;
    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, "-port")) {
            port = args.next() orelse unreachable;
            std.debug.print("Port: {s}\n", .{port});
        } else if (std.mem.eql(u8, arg, "-n")) {
            name = args.next() orelse unreachable;
            std.debug.print("Name: {s}\n", .{name});
        }
    }
    std.debug.print("\n{s}\n\n{s}\n", .{ port, name });
}
