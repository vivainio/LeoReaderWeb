root = global ? window

opendoc = (url) ->
    doc = $.ajax(url).done (data) ->
        t = $(this)
        console.log("Ajax ok " + data)
        

        
    