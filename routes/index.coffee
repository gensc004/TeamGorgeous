
#
# * GET home page.
#
exports.index = (req, res) ->
    res.render "index",
    title: "Lightside Set-Up"
    description : "This is our project base"
return