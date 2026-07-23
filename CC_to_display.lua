
local CCcolorsRGB = {
    colors.white, colors.orange, colors.magenta, colors.lightBlue, colors.yellow,
    colors.lime, colors.pink, colors.gray, colors.lightGray, colors.cyan,
    colors.purple, colors.blue, colors.brown, colors.green, colors.red, colors.black
}
io.input("data.CCimg")
local screenWidth, screenHeight = nil, nil
local data = io.read()
local width, height, frameData = data:match("(%d+), (%d+) %[(.*)%]")
local screen = peripheral.wrap("top")
local result = {}

screen.clear()
screen.setCursorPos(1, 1)
screen.setTextScale(0.5)
screenWidth, screenHeight = screen.getSize()

if tonumber(width) == screenWidth and tonumber(height) == screenHeight then
    print("Dimensions match, proceeding to load image.")
else
    print("Warning: Dimensions do not match. Image may not display correctly.")
    print("your monitors size: " .. screenWidth .. "x" .. screenHeight)
    print("image size: " .. width .. "x" .. height)
end

for value, count in frameData:gmatch("(%-?%d+):(%d+)") do
    value = tonumber(value)
    count = tonumber(count)

    for i = 1, count do
        table.insert(result, value)
    end
end

print("width =", width)
print("height =", height)
print("expected width =", screenWidth)
print("expected height =", screenHeight)
print("pixels expected =", width * height)
print("pixels loaded =", #result)

for y = 1, height do
    screen.setCursorPos(1, y)
    for x = 1, width do
        local pixel = result[(x - 1) * height + y]
        screen.setTextColor(CCcolorsRGB[pixel + 1])
        screen.write("O")
    end
end
