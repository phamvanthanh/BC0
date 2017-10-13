<template>
    <li><span  v-bind:class="{'wbstree-warning': isActive  }" class="wbstree-node wbstree-expanded" >
            <span :class="{bold: isFolder}" class="wbstree-expander"
                    @click="toggle" v-if="isFolder">[{{open ? '-' : '+'}}]
            </span>	
            <span  @click="clickNode"  class="wbstree-title" >										
                    {{node.code+ ' - '+node.name}}							
            </span>
            <span v-if="node.extension == 1" class="label bg-info-300">
                ex
            </span>
        </span>
    
        <ul v-show="open" v-if="isFolder">
            <swbs
                class="swbs"
                v-for="node in filterlist" v-bind:key="node.code"
                :node="node" 
                :removecodes="removecodes"
                :filterString="filterString" >
            </swbs>
            
            
        </ul>
    </li>
</template>
<script>

import treemixin from './treemixin';
export default {
    mixins: [treemixin],
    name: 'swbs',
    props: [
        'removecodes',
        'filterString'
    ],
    data() {
        return {     
          edit: false,
          form : new Form({
              project_id: this.$route.params.pid,
              code: null,
              name: null,
              quantify: 0,            
              parent_code: this.node.code,            
              extension: 1,
             
          })
        }
    },
   

    computed: { 
        isActive : function(){
            if(this.removecodes.indexOf(this.node.code) >=0)
                return true;
            return false;
        },         
        filterlist: {
            get() {
                var exp = new RegExp(this.filterString, 'i');

                function treeFilter(node, flag){        
                    return node.children.filter(function(item){
                        if(exp.test(item.code+' - '+item.name)) {                      
                            return true; 
                        }
                                
                        let c = item.children ? treeFilter(item) : false;

                        if(c.length == 0){
                            return false;
                        }else{
                            return c;
                        }
                    })
                    
                }

                let filtering = treeFilter(this.node, false) 
                if(this.node.children && filtering.length == 0 && this.$parent.filterlist.length > 0)
                    filtering = this.node.children;
                return filtering;
            },
            set(newVal) {
                
            }
        }
  
    },
    methods: {
   
        selectNode: function(){
            bus.$emit('selectremovecode', this.node.code); 
            if(this.$children)
                for( var i=0; i < this.$children.length; i++){                      
                    if(!this.$children[i].isActive)
                    this.$children[i].selectNode();                
                }           
        },
        deselectNode: function() {                  
            bus.$emit('deselectremovecode', this.node.code); 
            if(this.$parent.isActive)
              this.$parent.deselectNode();

        },
      

        
    }
    
}
</script>