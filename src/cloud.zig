const std = @import("std");
const rl = @import("raylib");
const util = @import("utils.zig");

pub const Cloud = struct {
    const Self = @This();

    const MIN_CLOUD_SPEED: f32 = 25;
    const MAX_CLOUD_SPEED: f32 = 100;

    const MIN_CLOUD_Y: f32 = 50;
    const MAX_CLOUD_Y: f32 = 200;

    texture: rl.Texture,
    x: f32,
    y: f32,
    speed: f32,

    pub fn init(texture: rl.Texture, rand: std.Random) Self {
        return Self{
            .texture = texture,
            .x = util.randomRange(f32, rand, 0, 1920),
            .y = util.randomRange(f32, rand, MIN_CLOUD_Y, MAX_CLOUD_Y),
            .speed = util.randomRange(f32, rand, MIN_CLOUD_SPEED, MAX_CLOUD_SPEED),
        };
    }

    // Update the state based on the time that has elapsed.
    pub fn update(self: *Self, rand: std.Random, deltaTime: f32) void {
        self.x += self.speed * deltaTime;
        if (self.x > 1920) {
            self.x = -@as(f32, @floatFromInt(self.texture.width));
            self.y = util.randomRange(f32, rand, 50, 200);
        }
    }

    pub fn draw(self: *Cloud) void {
        rl.drawTexture(self.texture, @intFromFloat(self.x), @intFromFloat(self.y), rl.Color.white);
    }
};
