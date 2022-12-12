const std = @import("std");
const time = std.time;
const Max = std.math.maxInt;
const Rng = std.rand.DefaultPrng;

const Operations = [_]u8{ '*', '/', '+', '-' };
const Operation = u8;
const Number = i8;
const Result = i16;

const Question = struct {
    n1: Number,
    n2: Number,
    op: Operation,
    re: Result,

    // generate a random question
    pub fn gen(rnd: *Rng) Question {
        var q: Question = undefined;
        q.n1 = rnd.random().int(Number);
        q.n2 = rnd.random().int(Number);
        if (q.n2 == 0) q.n2 += 1;
        q.op = Operations[rnd.random().int(usize) % Operations.len];
        q.re = Question.getResult(q.n1, q.n2, q.op);
        return q;
    }

    // get the result from the question
    fn getResult(n1: Number, n2: Number, op: Operation) Result {
        switch (op) {
            '+' => return @as(Result, n1) + @as(Result, n2),
            '-' => return @as(Result, n1) - @as(Result, n2),
            '/' => return @divFloor(n1, n2),
            '*' => return @as(Result, n1) * @as(Result, n2),
            else => unreachable,
        }
    }
};

pub fn main() !void {
    // setup basic I/O
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();
    var reader = stdin.reader();
    var writer = stdout.writer();

    // setup random number generator
    var now = time.nanoTimestamp();
    var rng = Rng.init(@intCast(u64, now));

    // declare input buffer
    var buff: [1024]u8 = undefined;

    // generate a random math question
    const q = Question.gen(&rng);

    // show the question to the user
    try writer.print("{} {c} {} = ?\n", .{ q.n1, q.op, q.n2 });
    try writer.print("=> {}\n", .{q.re});

    // get answer from the user
    const answer = try reader.readUntilDelimiter(&buff, '\n');
    const int_answer = try std.fmt.parseInt(Result, answer, 10);

    // check and show the flag is correct answer
    if (int_answer != q.re) {
        try writer.print("Not the right answer...\n", .{});
        try writer.print("Was expecting {}\n", .{q.re});
        std.os.exit(1);
    }
    try writer.print("Congrats, the flag is {{HELLO_THERE}}\n", .{});
}
