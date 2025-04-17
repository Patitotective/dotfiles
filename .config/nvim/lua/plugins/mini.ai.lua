-- local txt = [[
-- [ex. http://RegExr.com?2rjl6]
-- [adobe.com/go/flex]
-- [gskinner.com/products/spl]
-- https://google.com
-- /asdas/asdasd.org
-- https:google.com
-- www.cool.com.au
-- http://www.cool.com.au
-- http://www.cool.com.au/ersdfs
-- http://www.cool.com.au/ersdfs?dfd=dfgd@s=1
-- http://www.cool.com:81/index.html
-- ]]
-- -- local txt = "http://www.cool.com:81/index.html"
--
-- local function matchUrlPath(input)
--   local i = 1
--   while i <= #input do
--     -- print(i)
--     -- print(string.sub(input, i, i))
--     local a, b = string.find(input, "%w+:", i)
--     if a ~= nil and b ~= nil then
--       i = b
--       print(string.find(input, "%/%/", i))
--       if string.find(input, "%/%/", i) ~= nil then
--         i = i + 2
--       end
--       print(string.sub(input, a, i))
--     else
--       i = i + 1
--     end
--   end
-- end
--
-- print(matchUrlPath(txt))

return {
  "echasnovski/mini.ai",
  opts = {
    custom_textobjects = {
      -- Match URL/file path
      -- x = { [[%w+://[^%s)%]}"'`>]+]] },
    },
  },
}
