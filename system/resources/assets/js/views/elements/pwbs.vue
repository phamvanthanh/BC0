<template > 
<li>
    <div  class="wbs-item">
        <span :class="{bold: isFolder}" class="wbstree-expander"
              @click="toggle" v-if="isFolder">[{{open ? '-' : '+'}}]
        </span>					
        <span > 
            {{node.code + ' - ' + node.name}}
        </span>
    </div>
    <ul v-show="open" v-if="isFolder">
        <pwbs           
            v-for="node in filterlist" 
            :key="node.code"
            :node="node"
            :filterString="filterString" >
        </pwbs>								
    </ul>
</li>
</template>
<script>

import treemixin from './treemixin';

export default {
    mixins: [treemixin],
    name: 'pwbs',   
    props: ['node', 'filterString'],
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
    }

}
</script>