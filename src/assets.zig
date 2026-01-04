const std = @import("std");
const rl = @import("raylib");

pub const GameAssets = struct {
    const Self = @This();

    // Textures
    axe: rl.Texture,
    background: rl.Texture,
    bee: rl.Texture,
    branch: rl.Texture,
    cloud: rl.Texture,
    log: rl.Texture,
    player: rl.Texture,
    headstone: rl.Texture,
    tree: rl.Texture,
    treeAlt: rl.Texture,

    // Sounds
    death: rl.Sound,
    outOfTime: rl.Sound,
    chop: rl.Sound,

    // Fonts
    font: rl.Font,

    pub fn load() !GameAssets {
        const assets = GameAssets{
            .axe = try rl.loadTexture("graphics/axe.png"),
            .background = try rl.loadTexture("graphics/background.png"),
            .bee = try rl.loadTexture("graphics/bee.png"),
            .branch = try rl.loadTexture("graphics/branch.png"),
            .cloud = try rl.loadTexture("graphics/cloud.png"),
            .log = try rl.loadTexture("graphics/log.png"),
            .player = try rl.loadTexture("graphics/player.png"),
            .headstone = try rl.loadTexture("graphics/rip.png"),
            .tree = try rl.loadTexture("graphics/tree.png"),
            .treeAlt = try rl.loadTexture("graphics/tree2.png"),
            .death = try rl.loadSound("sounds/death.wav"),
            .outOfTime = try rl.loadSound("sounds/out_of_time.wav"),
            .chop = try rl.loadSound("sounds/chop.wav"),
            .font = try rl.loadFont("fonts/KOMIKAP_.ttf"),
        };

        rl.setSoundVolume(assets.death, 0.4);
        rl.setSoundVolume(assets.chop, 1.0);
        rl.setSoundVolume(assets.outOfTime, 0.7);

        return assets;
    }

    pub fn unload(self: Self) void {
        rl.unloadTexture(self.axe);
        rl.unloadTexture(self.background);
        rl.unloadTexture(self.bee);
        rl.unloadTexture(self.branch);
        rl.unloadTexture(self.cloud);
        rl.unloadTexture(self.log);
        rl.unloadTexture(self.player);
        rl.unloadTexture(self.headstone);
        rl.unloadTexture(self.tree);
        rl.unloadTexture(self.treeAlt);
        rl.unloadSound(self.death);
        rl.unloadSound(self.outOfTime);
        rl.unloadSound(self.chop);
        rl.unloadFont(self.font);
    }
};
