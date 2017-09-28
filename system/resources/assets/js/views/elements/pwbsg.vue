<template > 
    <li > 							
        <span v-bind:class="{ 'wbstree-active': isActive, 'wbstree-selected': isChosen }" class="wbstree-node wbstree-expanded "  >
            <span :class="{bold: isFolder}"  class="fancytree-expander"
                @click="toggle" v-if="isFolder">[{{open ? '-' : '+'}}]
            </span>
            <span @click="clickNode" class="wbstree-title" v-bind:class="{'chosen-by-other': isChosenByOthers}">
                 {{node.code+ ' - '+node.name}}
            </span>															
        </span>
        <ul v-show="open" v-if="isFolder">
            <pwbsg              
                v-for="node in node.children" v-bind:key="node.code"
                :node="node"
                :addcodes="addcodes"
                :disabledcodes="disabledcodes"
                :privatechosencodes="privatechosencodes" >
            </pwbsg>								
        </ul>
    </li>
</template>
<script>
import treemixin from './treemixin';
export default {
    mixins: [treemixin],
    name: 'pwbsg',
    props: {       
        addcodes: null,
        disabledcodes: null,
        privatechosencodes: null,
    },
    data() {
        return {
            isActive: false,
            isDisabled: false,
            isChosen: false,
            isChosenByOthers: false,
            updated: false,
        }
    },

    watch: {
        addcodes: function(){  
          this.activate();
        },
        disabledcodes: function(){
          this.disable();        
          this.chosenByOthers();
        },
        privatechosencodes: function(){                     
          this.choose();
          this.chosenByOthers();
        },
        
    },


    methods: {
        selectNode(){
            if(!this.isChosen && !this.isChosenByOthers) {        
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
          if(this.disabledcodes.indexOf(this.node.code) >= 0 ){
             this.isDisabled = true
             return ;
          }
          this.isDisabled = false;
        },
        choose() {                
            if(this.privatechosencodes.indexOf(this.node.code) >= 0) {          
                this.isChosen = true;   
                return;                
            }                 
            this.isChosen = false;  
        }, 
        chosenByOthers() {
       
             if(this.isDisabled && !this.isChosen && this.node.children == null) {
                 this.isChosenByOthers = true;
                 return;
             }
             this.isChosenByOthers = false;                      

        } 
      
    }
}

</script>
<style>
.chosen-by-other {
  background-color: #EF6C00 !important;
  border-color: #EF6C00;
  color: #fff !important;
}
</style>