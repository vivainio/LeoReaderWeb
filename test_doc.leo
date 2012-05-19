<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo (http://webpages.charter.net/edreamleo/front.html) -->
<?xml-stylesheet ekr_test?>
<leo_file xmlns:leo="http://www.leo-editor.org/2011/leo" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="ville.20120518223417.1389"><vh>Script to dump content to .leo.json</vh></v>
<v t="ville.20120427233328.1347"><vh>workbook.leo</vh></v>
<v t="ville.20120429101639.1363" a="E"><vh>Test tree</vh>
<v t="ville.20120429101639.1364" a="E"><vh>ch1</vh>
<v t="ville.20120429101639.1366"><vh>ch1.1</vh></v>
<v t="ville.20120429101639.1367"><vh>ch1.2</vh></v>
</v>
<v t="ville.20120429101639.1365" a="E"><vh>ch2</vh>
<v t="ville.20120518223417.1390"><vh>ch2.1</vh></v>
</v>
</v>
<v t="ville.20120427233328.1348"><vh>Terrys qmlshower</vh></v>
<v t="ville.20120427234823.1353"><vh>try qwrappers</vh></v>
<v t="ville.20120427235207.1355"><vh>create dv</vh>
<v t="ville.20120428001617.1357"><vh>t1</vh></v>
<v t="ville.20120503232842.1385"><vh>t4</vh></v>
<v t="ville.20120428001617.1358"><vh>t2</vh></v>
<v t="ville.20120503232842.1386"><vh>t5</vh></v>
</v>
<v t="ville.20120428225125.1361"><vh>standarditemmodel</vh></v>
</vnodes>
<tnodes>
<t tx="ville.20120427233328.1347">import leo.plugins.qmlnb.launchqmlnb
dv = leo.plugins.qmlnb.launcqmlnb.launchqmlnb.create_dv()
</t>
<t tx="ville.20120427233328.1348">@language python
from PyQt4.QtCore import QUrl, QObject

from PyQt4.QtDeclarative import QDeclarativeView
class QMLShower:
   def __init__(self, c):
       self.c = c
       c._qml_shower = self
       self.w = None
       c.free_layout.get_top_splitter().register_provider(self)
   def ns_provider_id(self):  # allow for re-registering, mainly for dev.
       return '__qml_shower'
   def ns_provides(self):  # what we can provide
       return [("Add QML shower", '__add_qml_shower')]
   def ns_provide(self, id_):  # provide it
       if id_ == '__add_qml_shower':
           g.unregisterHandler('select2', self.update)
           g.registerHandler('select2', self.update)
           if not self.w:
               self.w = self.make_widget()
           return self.w
   def make_widget(self):
       view = QDeclarativeView()
       path = g.os_path_join(g.computeLeoDir(), 'plugins', 'qmlnb', 'qml', 'leonbmain.qml')
       view.setSource(QUrl(path))
       view.setResizeMode(QDeclarativeView.SizeRootObjectToView)
       # Display the user interface and allow the user to interact with it.
       view.setGeometry(100, 100, 400, 240)
       view.show()
       #rootObject = view.rootObject()
       #rootobject.leo_c = self.c
       return view
   def update(self, tag, kwords):
       pass
   def closed(self, event):
       g.unregisterHandler('select2', self.update)

QMLShower(c)</t>
<t tx="ville.20120427234823.1353">import leo.core.leoqwrappers
reload(leo.core.leoqwrappers)
from leo.core.leoqwrappers import *
n = NodeWrapper(c, p.v)
print n
print n.children()</t>
<t tx="ville.20120427235207.1355">from PyQt4.QtCore import QUrl, QObject

from PyQt4.QtDeclarative import QDeclarativeView
from PyQt4.QtGui import QStandardItemModel,QStandardItem

class ModelWrapper:
    def __init__(self, fieldlist):
        self.rolenames = rn = {}
        self.roleids = ri = {}
        for n,f in enumerate(fieldlist):
            rid = n + 100
            rn[rid] = f
            ri[f] = rid
        self.model = mo = QStandardItemModel()
        mo.setRoleNames(rn)

    def mkitem(self, d):
        """ dict with field-&gt;value """        
        si = QStandardItem()
        for k,v in d.items():
            rid = self.roleids[k]
            si.setData(v, rid)
            
        return si
                   
    
class NbController:
        
    def addNode(self, p, styling = {}):
        v = p.v
        d = {"h" : v.h, "b" : v.b, "gnx" : v.gnx, "level" : p.level()}
        d.update(styling)
        self.gnxcache[v.gnx] = v    
        si = self.mw.mkitem(d )
        self.mw.model.appendRow(si)

    def add_all_nodes(self):
        for p in c.all_positions():                        
            self.addNode(p)
            
    def __init__(self):
        
        self.gnxcache = {}
        
        self.mw = ModelWrapper(["h", "b", "gnx", "level", "style"])
 
        self.add_all_nodes()       
        c._view = view = QDeclarativeView()
        ctx = view.rootContext()        
        
        
        
        ctx.setContextProperty("nodesModel", self.mw.model)
                
        path = g.os_path_join(g.computeLeoDir(), 'plugins', 'qmlnb', 'qml', 'leonbmain.qml')
        view.setSource(QUrl(path))
        view.setResizeMode(QDeclarativeView.SizeRootObjectToView)
        # Display the user interface and allow the user to interact with it.
        view.setGeometry(100, 100, 800, 240)
        view.show()
        
        c.dummy = view
        
NbController()        </t>
<t tx="ville.20120428001617.1357"># aaoao
</t>
<t tx="ville.20120428001617.1358">Enter more text here

should be enlightening

#oeoeoeoe
</t>
<t tx="ville.20120428225125.1361">from PyQt4.QtGui import QStandardItemModel,QStandardItem



</t>
<t tx="ville.20120429101639.1363">Root level content</t>
<t tx="ville.20120429101639.1364">Ch 1 content</t>
<t tx="ville.20120429101639.1365">Ch 2 content</t>
<t tx="ville.20120429101639.1366">Level 2

aeaoaoao</t>
<t tx="ville.20120429101639.1367">Also level 2</t>
<t tx="ville.20120503232842.1385"></t>
<t tx="ville.20120503232842.1386"></t>
<t tx="ville.20120518223417.1389">@language python

# ctrl+b here to dump the document for leo, for reading

class JsonController:
    def to_json (self,c,p=None):
    
       '''Convert p's tree to JSON, or the entire outline if p is
    None.'''
    
       if p:
           top = [p.v.gnx]
           nodes = list(set([p.v for p in p.self_and_subtree()]))
       else:
           top = [v.gnx for v in c.hiddenRootNode.children]
           nodes = [v for v in c.all_unique_nodes()]
    
       nodes = [self.vnode_dict(v) for v in nodes]
       d = {'top':top,'nodes':nodes}
       s = json.dumps(d)
       return s
    
    def vnode_dict (self,v):
    
       return {
           'gnx': v.gnx,
           'h':v.h, 'b':v.b,
           # 'ua': v.u,
           'children': [z.gnx for z in v.children]
       }
       
       
import json
jc = JsonController()
s = jc.to_json(c,p=None)
open("./test_doc.leo.json", "w").write(s)
d = json.loads(s)   </t>
<t tx="ville.20120518223417.1390"></t>
</tnodes>
</leo_file>
