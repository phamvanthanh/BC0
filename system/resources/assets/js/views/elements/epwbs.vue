<template>
    <li><span  v-bind:class="{'wbstree-warning': isActive  }"  class="wbstree-node wbstree-expanded" >
            <span :class="{bold: isFolder}" class="wbstree-expander"
                    @click="toggle" v-if="isFolder">[{{open ? '-' : '+'}}]
            </span>	
            <span  @click.stop="clickNode"   @dblclick="changeType" class="wbstree-title"  >										
                    <span >{{node.code}} </span><span> - </span><span>{{node.name}}</span>							
            </span>
            <span v-if="node.extension == 1" class="label bg-info-300">
                ex
            </span>
        </span>
    
        <ul v-show="open" v-if="isFolder">
            <epwbs
                class="epwbs"
                v-for="node in filterlist" v-bind:key="node.code"
                :node="node" 
                :removecodes="removecodes"
                :isNewEntry="isNewEntry"             
                :jobableId="jobableId"
                :filterString="filterString"
                >
            </epwbs>
        
            <li >
                <span v-if="edit">
           
                    <form method="post" @submit.prevent="onSubmit" @change="form.errors.clear($event.target.name)"  > 
                        <div class="col-md-12 pb-10">   
                             <div class="form-group">       
                                <div class="col-md-2">     
                                    <input  type="text" class="form-control" name="code" v-model="form.code" placeholder="Code" > 
                                </div>
                                <div class="col-md-5">
                                    <input  type="text" class="form-control" name="name" v-model="form.name" placeholder="Name"  >
                                </div>
                              </div>
                        </div>
                        <div class="col-md-12 pb-10"> 
                            <div class="form-group">
                                 <div class="col-md-7">
                                    <textarea type="text" class="form-control" name="description" v-model="form.description" placeholder="Description"></textarea> 
                                 </div>
                            </div>
                        </div>
                         <div class="col-md-12 pb-10">
                            <div class="form-group">
                                <div class="col-md-7">                             
                                    <button type="submit"  name="submit" :disabled="form.errors.any()" class="btn btn-primary" >Save</button>
                                    <button @click="cancel" type="button" class="btn btn-default ml-10">Cancel</button>
                                </div>
                             </div>
                        </div> 								
                      
                    </form>										
               

                </span>
                <span v-else @click="addChild" class="add" >+</span>
            </li>
        </ul>
    </li>
</template>
<script>

import treemixin from './treemixin';
export default {
    mixins: [treemixin],
    name: 'epwbs',
    props:['jobableId', 'removecodes', 'isNewEntry', 'filterString'],

    data() {
        return {     
          edit: false,
          form : new Form({
              project_id: null,
              code: null,
              name: null,
              description: '',                  
              parent_code: this.node.code,            
              extension: 1,
             
          }),
          u: new Form({
              name: 'm2'
          })
        }
    },
    
    mounted() {                            
        bus.$emit('disabledcode', this.node.code);    
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
        changeType: function () {      
          if (!this.isFolder) {
            Vue.set(this.node, 'children', [])
            this.addChild()
            this.open = true
          }
          
        },
        addChild: function(){
            
          if(!this.isNewEntry){  
            this.edit = true;       
            bus.$emit('newentry', true);
          }
        },
        cancel: function (){        
          if(this.isNewEntry){              
            this.edit = false;
            bus.$emit('newentry', false);
          }
        },
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
        onSubmit: function() {
            this.form.project_id = this.jobableId;
            this.form.post('/api/projects/'+this.form.project_id+'/pwbs/create')
                .then(response => {
                    notice(this.form.notifications, 6000);
                    bus.$emit('refreshPwbs');
                    this.cancel();
                })
                .catch(errors => {
                    notice(this.form.notifications, 6000);
                    console.log(errors);
                })
        },
    }
    
}
</script>