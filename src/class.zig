pub const Class = struct {
    name: []const u8,

    pub fn init() Class {
        return Class{
            .name = "Mage",
        };
    }
    pub fn generateClasses() void {}
    pub fn GetClassName(me: Class) []const u8 {
        return me.name;
    }
};

pub const classes = [_]Class{
    Class{ .name = "Mage" },
    Class{ .name = "Mage" },
    Class{ .name = "Rouge" },
    Class{ .name = "Bar" },
    Class{ .name = "Mage" },
    Class{ .name = "Mage" },
};
