const std = @import("std");
pub fn Random(max_u8: u8) !u8 {
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    return rand.intRangeAtMost(u8, 0, max_u8);
    // return r;
}
pub inline fn RandomT(comptime T: type, max_u8: usize) !T {
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    return rand.intRangeAtMost(T, 0, max_u8);
    // return r;
}
pub fn Input(allocator: std.mem.Allocator) ![]const u8 {
    const stdin = std.io.getStdIn().reader();

    const bare_line = try stdin.readUntilDelimiterAlloc(
        allocator,
        '\n',
        8192,
    );
    const input = std.mem.trim(u8, bare_line, "\r");
    return input;
}

// const a = rand.float(f32);
// const b = rand.boolean();
// const c = rand.int(u8);

// std.debug.print("a: {}\nc: {}\nd: {}\n", .{ a, c, d });

// const foo = [_]u8{
//     rand.intRangeAtMost(u8, 0, 10),
//     rand.intRangeAtMost(u8, 0, 10),
//     rand.intRangeAtMost(u8, 0, 10),
//     rand.intRangeAtMost(u8, 0, 10),
//     rand.intRangeAtMost(u8, 0, 10),
//     rand.intRangeAtMost(u8, 0, 10),
//     rand.intRangeAtMost(u8, 0, 10),
// };
// for (foo) |value| {
//     std.debug.print("{}\n", .{value});
// }

//suppress unused constant compile error
// _ = .{ a, b, c, d };
//
