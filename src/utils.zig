const std = @import("std");

pub fn randomRange(comptime T: type, rand: std.Random, min: T, max: T) T {
    return switch (@typeInfo(T)) {
        .int => rand.intRangeAtMost(T, min, max),
        .float => min + rand.float(T) * (max - min),
        else => @compileError("randomRange only supports integers and floats"),
    };
}
