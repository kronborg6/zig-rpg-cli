pub const Class = struct {
    const self = @This();
    name: []const u8,

    pub fn init() self {
        return self{
            .name = "Mage",
        };
    }
    pub fn GetClassName(me: self) []const u8 {
        return me.name;
    }
};
