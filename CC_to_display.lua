
local CCcolorsRGB = {
    colors.white, colors.orange, colors.magenta, colors.lightBlue, colors.yellow,
    colors.lime, colors.pink, colors.gray, colors.lightGray, colors.cyan,
    colors.purple, colors.blue, colors.brown, colors.green, colors.red, colors.black
}
io.input("data.CCimg")
local data = io.read()
local width, height, frameData = data:match("(%d+), (%d+) %[(.*)%]")
local screen = peripheral.wrap("top")
local result = {}

for value, count in frameData:gmatch("(%-?%d+):(%d+)") do
    value = tonumber(value)
    count = tonumber(count)

    for i = 1, count do
        table.insert(result, value)
    end
end

screen.clear()
screen.setCursorPos(1, 1)
screen.setTextScale(0.5)

for y = 1, height do
    for x = 1, width do
        local pixel = result[(y - 1) * width + x]
        screen.setTextColor(CCcolorsRGB[pixel + 1])
        screen.write("O")
    end
    screen.setCursorPos(1, y + 1)
end

print(#result, width * height)