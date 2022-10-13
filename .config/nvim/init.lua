vim.g.mapleader = ","

local o = vim.opt

o.relativenumber = true
o.encoding = "UTF-8"
o.shiftwidth = 4
o.tabstop= 4
o.expandtab = true

require("plugins")
