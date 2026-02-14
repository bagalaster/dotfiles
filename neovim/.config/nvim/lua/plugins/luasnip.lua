return {
	"L3MON4D3/LuaSnip",
    config = function()
        local ls = require('luasnip')
        ls.setup()
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        ls.add_snippets("sql", {
	-- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.
            s("::model", {
                -- Simple static text.
                t({"MODEL (", ""}),
                t("\tname "), i(1), t({",", ""}),
                t({"\tdescription \"\"\"", "\t\"\"\",", ""}),
                t({"\towner @get_owner(),", ""}),
                t({"\tkind FULL,", ""}),
                t({"\ttable_format iceberg,", ""}),
                t({"\tcolumn_descriptions (", "\t),", ""}),
                t({"\taudits (", "\t),", ""}),

                t({");", "", ""}),
                t({"with final as (", ""}),
                t({"\t"}), i(0), t({"", ""}),
                t({")", "", ""}),
                t({"select * from final", ""})
            }),
        })
    end
}
