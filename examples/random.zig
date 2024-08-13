const std = @import("std");
pub fn main() !void {
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 10);

    std.debug.print("a: {}\nc: {}\nd: {}\n", .{ a, c, d });

    const foo = [_]u8{
        rand.intRangeAtMost(u8, 0, 10),
        rand.intRangeAtMost(u8, 0, 10),
        rand.intRangeAtMost(u8, 0, 10),
        rand.intRangeAtMost(u8, 0, 10),
        rand.intRangeAtMost(u8, 0, 10),
        rand.intRangeAtMost(u8, 0, 10),
        rand.intRangeAtMost(u8, 0, 10),
    };
    for (foo) |value| {
        std.debug.print("{}\n", .{value});
    }

    //suppress unused constant compile error
    _ = .{ a, b, c, d };
}
