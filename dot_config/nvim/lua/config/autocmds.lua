-- TODO: config it
-- Conceal all Special Characters with 💩
local function conceal_all_special_chars()
    -- 全角スペース: IDEOGRAPHIC SPACE (U+3000)
    vim.cmd([[syntax keyword Operator \u3000 conceal cchar=💩]])
    -- ノーブレークスペース: NO-BREAK SPACE (U+00A0)
    vim.cmd([[syntax keyword Operator \u00a0 conceal cchar=💩]])
    -- オガム文字のスペース: OGHAM SPACE MARK (U+1680)
    vim.cmd([[syntax keyword Operator \u1680 conceal cchar=💩]])
    -- 1 enと等しい文字幅を有するスペース: EN QUAD (U+2000)
    vim.cmd([[syntax keyword Operator \u2000 conceal cchar=💩]])
    -- : EM QUAD (U+2001)
    vim.cmd([[syntax keyword Operator \u2001 conceal cchar=💩]])
    -- 1 enと等しい文字幅を有するスペース: EN SPACE (U+2002)
    vim.cmd([[syntax keyword Operator \u2002 conceal cchar=💩]])
    -- : EM SPACE (U+2003)
    vim.cmd([[syntax keyword Operator \u2003 conceal cchar=💩]])
    -- : THREE-PER-EM SPACE (U+2004)
    vim.cmd([[syntax keyword Operator \u2004 conceal cchar=💩]])
    -- : FOUR-PER-EM SPACE (U+2005)
    vim.cmd([[syntax keyword Operator \u2005 conceal cchar=💩]])
    -- : SIX-PER-EM SPACE (U+2006)
    vim.cmd([[syntax keyword Operator \u2006 conceal cchar=💩]])
    -- : FIGURE SPACE (U+2007)
    vim.cmd([[syntax keyword Operator \u2007 conceal cchar=💩]])
    -- : PUNCTUATION SPACE (U+2008)
    vim.cmd([[syntax keyword Operator \u2008 conceal cchar=💩]])
    -- : THIN SPACE (U+2009)
    vim.cmd([[syntax keyword Operator \u2009 conceal cchar=💩]])
    -- : HAIR SPACE (U+200A)
    vim.cmd([[syntax keyword Operator \u200a conceal cchar=💩]])
    -- : ZERO WIDTH SPACE (U+200B)
    vim.cmd([[syntax keyword Operator \u200b conceal cchar=💩]])
    -- : NARROW NO-BREAK SPACE (U+202F)
    vim.cmd([[syntax keyword Operator \u202f conceal cchar=💩]])
    -- : ZERO WIDTH NO-BREAK SPACE (U+FEFF)
    vim.cmd([[syntax keyword Operator \ufeff conceal cchar=💩]])
    -- : MEDIUM MATHEMATICAL SPACE (U+205F)
    vim.cmd([[syntax keyword Operator \u205f conceal cchar=💩]])
    -- : MONGOLIAN VOWEL SEPARATOR (U+180E)
    vim.cmd([[syntax keyword Operator \u180f conceal cchar=💩]])
    -- : EM DASH (U+2014)
    vim.cmd([[syntax keyword Operator \u2014 conceal cchar=💩]])
    -- : LINE FEED(LF) (U+000A)
    vim.cmd([[syntax keyword Operator \u000a conceal cchar=💩]])
    -- : CARRIAGE RETURN(CR) (U+000D)
    vim.cmd([[syntax keyword Operator \u000d conceal cchar=💩]])
end

local casc = vim.api.nvim_create_augroup("conceal_all_special_chars", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
    group = casc,
    pattern = "*",
    callback = conceal_all_special_chars,
})
