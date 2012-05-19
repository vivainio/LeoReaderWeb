root = window

class LeoAccess
    constructor: ->
        @nodes = {}
        @parentgnx = ""
        $("#btnback").click =>
            console.log "Click back"
            @showSubtree @parentgnx
    
    
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
        
        that = this
        $r.empty()
        #$cont.empty()
        
        $b = $("#bodytext")
        $b.text(n.b)
        $("#hstring").text(n.h)
        console.log "Show subtree for " + parentGnx
        
        for chignx in n.children
            chin = @nodes[chignx]
            console.log "h = " + chin.h
            $n = $('<li><a href="#"/>' + chin.h + '</li>')
            $a = $n.find("a")
            $a.data "gnx", chignx
            $a.click ->
                console.log $(this)
                gnx = $(this).data("gnx")
    
                that.parentgnx = parentGnx
                that.showSubtree gnx
                
            console.log("Appended " + $n)
            $r.append($n)
            
        $r.listview('refresh')
            

        
        

console.log("Parsing")
#root.LeoAccess = LeoAccess
        
$(document).ready ->
    console.log "Start dl"
    root.la = new LeoAccess()
    root.la.opendoc("test_doc.leo.json")
    
    