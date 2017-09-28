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
            <gwbs
                class="gwbs"
                v-for="node in node.children" v-bind:key="node.code"
                :node="node" 
                :removecodes="removecodes" >
            </gwbs>
            
            
        </ul>
    </li>
</template>
<script>

import treemixin from './treemixin';
export default {
    mixins: [treemixin],
    name: 'gwbs',
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
    props: {
        removecodes: null,
    
    },

    computed: { 
        isActive : function(){
            if(this.removecodes.indexOf(this.node.code) >=0)
                return true;
            return false;
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