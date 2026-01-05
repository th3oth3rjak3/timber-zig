const std = @import("std");
const rl = @import("raylib");

pub const Message = struct {
    const Self = @This();

    const FONT_SIZE: f32 = 48;
    const SPACING: f32 = 2;
    const PADDING: f32 = 12;

    isActive: bool = false,
    text: [:0]const u8 = "",
    font: *const rl.Font,

    pub fn init(font: *const rl.Font) Self {
        return Self{
            .font = font,
        };
    }

    pub fn show(self: *Self, text: [:0]const u8) void {
        self.text = text;
        self.isActive = true;
    }

    pub fn hide(self: *Self) void {
        self.isActive = false;
    }

    pub fn draw(self: *Self) void {
        if (!self.isActive) return;

        const text_size = rl.measureTextEx(
            self.font.*,
            self.text,
            FONT_SIZE,
            SPACING,
        );

        // Center on screen
        const pos = rl.Vector2{
            .x = (1920 - text_size.x) / 2,
            .y = (1080 - text_size.y) / 2,
        };

        // Background
        rl.drawRectangleRec(
            rl.Rectangle{
                .x = pos.x - PADDING,
                .y = pos.y - PADDING,
                .width = text_size.x + PADDING * 2,
                .height = text_size.y + PADDING * 2,
            },
            rl.Color{ .r = 0, .g = 0, .b = 0, .a = 160 },
        );

        // Text
        rl.drawTextEx(
            self.font.*,
            self.text,
            pos,
            FONT_SIZE,
            SPACING,
            rl.Color.white,
        );
    }
};
