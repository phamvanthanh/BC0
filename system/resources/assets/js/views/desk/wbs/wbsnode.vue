<template id="wbs-template"> 
    <li > 							
        <span v-if="!editing" v-bind:class="{ 'wbstree-danger': isActive }" class="wbstree-node wbstree-expanded "  >
            <span :class="[isFolder? 'bold': '', 'wbstree-expander']"  
                @click="toggle" v-if="isFolder">[{{open ? '-' : '+'}}]
            </span>
            <span @click="clickNode"  @dblclick="changeType" class="wbstree-title">
                 {{node.code+ ' - '+node.name}}
            </span>	   

            <span v-if="editMode"  class="pl-10 wbstree-item pointer text-danger" ><i  @click="deleteNode" v-if="isActive" class="icon-cross2" > </i></span></span>
            <span v-if="editMode && !editing"  class="pl-10 wbstree-item pointer text-primary" ><i  @click="editNode" v-if="isActive" class="icon-pencil3" > </i></span></span>														
        </span>
         <span v-if="editing">
            <form method="post" @submit.prevent="onSubmit" @change="form.errors.clear($event.target.name)"  > 
                <div class="col-md-12 pb-10 pl-0">   
                        <div class="form-group">       
                        <div class="col-md-2">     
                            <input  type="text" class="form-control" name="code" v-model="form.code" placeholder="Code" > 
                        </div>
                        <div class="col-md-5">
                            <input  type="text" class="form-control" name="name" v-model="form.name" placeholder="Name"  >
                        </div>
                        </div>
                </div>
                <div class="col-md-12 pb-10 pl-0"> 
                    <div class="form-group">
                            <div class="col-md-7">
                            <textarea type="text" class="form-control" name="description" v-model="form.description" placeholder="Description"></textarea> 
                            </div>
                    </div>
                </div>
                    <div class="col-md-12 pb-10 pl-0">
                    <div class="form-group">
                        <div class="col-md-4">                             
                            <button type="submit"  name="submit" :disabled="form.errors.any()" class="btn btn-primary" >Save</button>
                            <button @click="cancelEditing" type="button" class="btn btn-default ml-20">Cancel</button>
                        </div>
                        </div>
                </div> 								
                
            </form>										
        </span>
        <ul v-show="open" v-if="isFolder">
            <wbs
                class = "wbs"
                v-for = "node in filterlist" v-bind:key="node.code"
                :node = "node"
                :editMode = "editMode"
                :isNewEntry = "isNewEntry"
                :filterString = "filterString" >
            </wbs>
            <li v-if="editMode" >
                <span v-if="edit">
                    <form method="post" @submit.prevent="onSubmit" @change="form.errors.clear($event.target.name)"  > 
                        <div class="col-md-12 pb-10 pl-0">   
                             <div class="form-group">       
                                <div class="col-md-2">     
                                    <input  type="text" class="form-control" name="code" v-model="form.code" placeholder="Code" > 
                                </div>
                                <div class="col-md-5">
                                    <input  type="text" class="form-control" name="name" v-model="form.name" placeholder="Name"  >
                                </div>
                              </div>
                        </div>
                        <div class="col-md-12 pb-10 pl-0"> 
                            <div class="form-group">
                                 <div class="col-md-7">
                                    <textarea type="text" class="form-control" name="description" v-model="form.description" placeholder="Description"></textarea> 
                                 </div>
                            </div>
                        </div>
                         <div class="col-md-12 pb-10 pl-0">
                            <div class="form-group">
                                <div class="col-md-4">                             
                                    <button type="submit"  name="submit" :disabled="form.errors.any()" class="btn btn-primary" >Save</button>
                                    <button @click="cancel" type="button" class="btn btn-default ml-20">Cancel</button>
                                </div>
                             </div>
                        </div> 								
                      
                    </form>										
                </span>
                <span v-else @click="addChild" class="pointer" >+</span>
            </li>								
        </ul>
    </li>
</template>
<script>
import treemixin from './../../elements/treemixin';
let current = null;
export default {
    mixins: [treemixin],
    name: 'wbs',
    props: ['editMode', 'isNewEntry', 'filterString'],
   
    data() {
        return {
            edit: false, //open new entry
            editing: false, // Edit current node
            isActive: false,     
            match:false,
            form: new Form({
                id: null,
                code: null,
                parent_code: this.node.code,  
                name: null,
                description: ''
            }),

        }
    },

    computed: {
       filterlist: { get(){
           
            var exp = new RegExp(this.filterString, 'i');
            let filtering;
            function treeFilter(node, flag){        
                 return node.children.filter(function(item){
                    if(exp.test(item.code+' - '+item.name)) { 
                    
                        return true; 
                        
                    }
                               
                    let c = item.children ? treeFilter(item) : false;
                 
                    if(c.length == 0){                        
                        return false;

                    }
                    else {
                        return c;
                    }
                })
                   
            }

            filtering = treeFilter(this.node, false);

            if(this.node.children && filtering.length == 0 && this.$parent.filterlist.length > 0) {
                  filtering = this.node.children;            
                  
            }           

            return filtering;
        },
        set(newVal) {
          

        }
       }

    },
    methods: {
        changeType() {      
          if (!this.isFolder) {
            Vue.set(this.node, 'children', [])
            this.addChild()
            this.open = true
          }
          
        },
        cancel() {   
             
          if(this.isNewEntry){              
            this.edit = false;
            if(Object.keys(this.node.children).length == 0)
                Vue.delete(this.node, 'children');
            bus.$emit('newentry', false);
          }
        },
        cancelEditing() {   
             
          if(this.isNewEntry){              
            this.editing = false;       
            bus.$emit('newentry', false);
            this.form.id = null;
            this.form.code = null;
            this.form.name = null;
            this.form.description = null;
            this.isActive = false;
           
          }
        },
        selectNode(){
           if(current)
            current.isActive = false;
           this.isActive = true; 
           current = this;        
        
        },
        deleteNode() {
            if(confirm('Deleting items in global Wbs will consequently delete items of which included in projects. Make sure they are not included in projects.')) {
                  this.form.parent_code = this.node.parent_code;
                  this.form.code = this.node.code;
                  this.form.name = this.node.name;
                  this.form.post('/api/desk/wbs/delete')
                    .then(({data})=>{   
                                  
                        bus.$emit('refreshwbs');
                        notice(this.form.notifications, 6000);})
                    .catch((error)=>{
                        notice(this.form.notifications, 6000);})
            }
          

        },
        editNode() {
            if(!this.isNewEntry) {
                this.editing = true; 
                bus.$emit('newentry', true);
                this.form.id = this.node.id;
                this.form.code = this.node.code;
                this.form.parent_code = this.node.parent_code;
                this.form.name = this.node.name;
                this.form.description  = this.node.description;    
            }
           

        },
        deselectNode() {             
           this.isActive = false;            
        },  
        addChild(){            
          if(!this.isNewEntry){  
            this.edit = true;     
            this.form.parent_code = this.node.code  
            bus.$emit('newentry', true);
          }
        },  
        onSubmit() {
          
            this.form.post('/api/desk/wbs')
                .then(({data})=>{                  
                    bus.$emit('newentry', false);
                    bus.$emit('refreshwbs');
                    this.edit = false;
                    this.isActive = false;
                    this.editing = false;
                    notice(this.form.notifications, 6000);
                    this.form.reset();
                    })
                .catch((error)=>{
                    notice(this.form.notifications, 6000);
                    
                })

        }  
      
    }
}

</script>