$(document).ready(() => {
    $('circle.head').hover(
        () => {
        $('circle.head').css({
            "fill": "red", 
            "stroke-width" : "4px"
        })
        $('line.right-arm').attr({
            "x2" : "440",
            "y2" : "200"
        })
        $('line.left-arm').attr({
            "x2" : "250",
            "y2" : "200"
        })
        }, 
        () => {
        $('circle.head').css("fill", "none")
        $('circle.eye').css({
            "fill": "black",
            "stroke-width" : "0.5px"
        })
        $('line.right-arm').attr({
            "x2" : "400",
            "y2" : "350"
        })
        $('line.left-arm').attr({
            "x2" : "290",
            "y2" : "350"
        })
    })
})