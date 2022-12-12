const std = @import("std");
const contains = std.mem.containsAtLeast;
const equals = std.testing.expectEqualSlices;
const lower = std.ascii.toLower;
const print = std.debug.print;

const Allocator = std.mem.Allocator;

const DuplicateEncoder = struct {
    pub fn bufEncode(buff: []u8, str: []const u8) []const u8 {
        var i: usize = 0;
        for (str) |c| {
            if (contains(u8, str, 2, &[_]u8{lower(c)})) {
                buff[i] = ')';
            } else {
                buff[i] = '(';
            }
            i += 1;
        }
        return buff;
    }

    pub fn allocEncode(allocator: Allocator, str: []const u8) ![]const u8 {
        var buff = try allocator.alloc(u8, str.len);
        const encoded = bufEncode(buff, str);
        return encoded;
    }
};

test "DuplicateEncoderTest" {
    print("\n", .{});
    const str: []const []const u8 = &.{
        "din",
        "recede",
        "Success",
        "(( @",
    };
    const ans: []const []const u8 = &.{
        "(((",
        "()()()",
        ")())())",
        "))((",
    };

    var allocator = std.testing.allocator;
    var i: usize = 0;
    while (i < str.len) : (i += 1) {
        const encoded = try DuplicateEncoder.allocEncode(allocator, str[i]);
        defer allocator.free(encoded);
        equals(u8, encoded, ans[i]) catch {
            print("{s}: {s} != {s}\n", .{ str[i], encoded, ans[i] });
            continue;
        };
        print("{s}: {s} == {s}\n", .{ str[i], encoded, ans[i] });
    }
}
