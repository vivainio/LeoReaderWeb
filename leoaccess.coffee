root = window

class LeoAccess
    constructor: ->
        @nodes = {}
        
    opendoc: (url) ->
        $.getJSON url, (data) =>
            console.log "got json! "
            for n in data.nodes
                
                @nodes[n.gnx] =
                    b : n.b
                    h : n.h
                    children : n.children
                    
                console.log "Got h " + @nodes[n.gnx].h
                    
            
            @nodes[""] =
                b : "hidden root"
                h : "hidden root"
                children : data.top
                
                
            @showSubtree ""
                
            #t = $(this)
            #console.log("Ajax ok " + data)
    showSubtree: (parentGnx) ->
        n = @nodes[parentGnx]
        $r = $("#lchildren")
        #$page = $("#nodespage")
        
        $r.empty()
        #$cont.empty()
        
        console.log "Show subtree for " + parentGnx
        for chignx in n.children
            chin = @nodes[chignx]
            console.log "h = " + chin.h
            $n = $('<li><a href=""/>' + chin.h + '</li>')
            console.log("Appended " + $n)
            $r.append($n)
            
        $r.listview('refresh')
            

        
        

console.log("Parsing")
root.LeoAccess = LeoAccess
        
$(document).ready ->
    console.log "Start dl"
    root.la = new LeoAccess()
    root.la.opendoc("test_doc.leo.json")
    
    