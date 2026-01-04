const std = @import("std");
const rl = @import("raylib");
const assets = @import("assets.zig");
const util = @import("utils.zig");
const cloud_import = @import("cloud.zig");
const bee_import = @import("bee.zig");

const screenWidth = 1920;
const screenHeight = 1080;

pub fn main() anyerror!void {
    var prng = std.Random.DefaultPrng.init(@bitCast(std.time.timestamp()));
    const rand = prng.random();

    rl.initWindow(screenWidth, screenHeight, "Timber!!");
    defer rl.closeWindow();
    rl.setTargetFPS(120);

    rl.initAudioDevice();
    defer rl.closeAudioDevice();

    const gameAssets = try assets.GameAssets.load();
    defer gameAssets.unload();

    var clouds: [3]cloud_import.Cloud = undefined;
    for (&clouds) |*c| {
        c.* = cloud_import.Cloud.init(gameAssets.cloud, rand);
    }

    var bee = bee_import.Bee.init(gameAssets.bee, rand);

    // Game Loop
    while (!rl.windowShouldClose()) {
        // deltaTime
        const dt = rl.getFrameTime();

        // Update State
        for (&clouds) |*c| {
            c.update(rand, dt);
        }

        bee.update(rand, dt);

        // Render
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawTexture(gameAssets.background, 0, 0, rl.Color.white);
        for (&clouds) |*c| {
            c.draw();
        }

        bee.draw();
    }
}
