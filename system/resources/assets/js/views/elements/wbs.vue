<template id="wbs-template"> 
    <li > 							
        <span v-bind:class="{ 'wbstree-active': isActive, 'wbstree-selected': isDisabled }" class="wbstree-node wbstree-expanded "  >
            <span :class="{bold: isFolder}"  class="wbstree-expander"
                @click="toggle" v-if="isFolder">[{{open ? '-' : '+'}}]
            </span>
            <span @click="clickNode" class="wbstree-title">
                 {{node.code+ ' - '+node.name}}
            </span>															
        </span>
        <ul v-show="open" v-if="isFolder">
            <wbs
                class="wbs"
                v-for="node in filterlist" v-bind:key="node.code"
                :node="node"
                :addcodes="addcodes"
                :disabledcodes="disabledcodes"
                :filterString="filterString" >
            </wbs>								
        </ul>
    </li>
</template>
<script>
import treemixin from './treemixin';
export default {
    mixins: [treemixin],
    name: 'wbs',
    props:['addcodes', 'disabledcodes', 'filterString'],
    data() {
        return {
            isActive: false,
            isDisabled: false,
        }
    },
    created() {
        this.disable();  
    },
    updated() {
        if(!this.updated){
            if(this.disabledcodes.length>0){
                this.disable();   
                this.updated = true;  
            }
        }        
    },
    watch: {
        addcodes: function(){  
          this.activate();
        },
        disabledcodes: function(){
          this.disable();
        },
        
    },

    computed: {
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
        selectNode(){
            if(!this.isDisabled) {        
            bus.$emit('addcode', this.node.code); 
            if(this.$parent.node)           
                this.$parent.selectNode();

            }          
        
        },
        deselectNode() {            
            bus.$emit('deselectraddcode', this.node.code);
           // this.isActive = false;              
            if(this.$children)
            for( var i=0; i < this.$children.length; i++) {                      
              if(this.$children[i].isActive)
                this.$children[i].deselectNode();                      
            }       
        },
        activate() {
          if(this.addcodes.indexOf(this.node.code) >= 0){       
            this.isActive = true;
            return;
          }
          this.isActive = false;

        },
        disable() {        
          if(this.disabledcodes.indexOf(this.node.code) >= 0){
            this.isDisabled = true;        
            return;
          }
          this.isDisabled = false;
        },
      
    }
}

</script>