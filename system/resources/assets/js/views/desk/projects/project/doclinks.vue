<template  >
<div class="panel panel-flat">
     
    <div  class="panel-heading">       
        <div class="heading-elements">
            <div class="heading-btn">
                <div class="form-group">
                    <div class="switch-box">												  
                        <label class="switch ">	
                            <span class="switch-label">Edit</span>																										
                            <input v-model="editMode" @click="editToggle"type="checkbox" name="edit" >
                            
                            <div class="slider"></div>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div  class="panel-body">
        <div class="row" v-if="editMode">
                <form @submit.prevent="onSubmit" method="post" >
                
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label>Caption: <span class="text-danger">*</span></label>
                            <input v-model="form.caption" class="form-control required">
                        </div>
                    </div>
                    <div class="col-sm-7">
                        <div class="form-group">
                            <label>Link: <span class="text-danger">*</span></label>
                            <input v-model="form.url" class="form-control required">
                        </div>
                    </div>
                    <div class="col-sm-1">
                        <div class="form-group">
                            <label class="transparent" >*</label>
                            <button type="submit" class="btn btn-primary form-control">Save</button>
                        </div>
                    </div>
                    <div class="col-sm-1">
                        <div class="form-group">
                            <label class="transparent" >*</label>
                            <button @click="reset" type="button"  class="btn btn-default form-control">Clear</button>
                        </div>
                    </div>
                </form>
        </div>
        <div  >
            <v-client-table 
                :data="links" 
                :columns="columns" 
                :options="options">
                <template slot="link" scope="props">
                    <a :href="props.row.url" target="_blank" >{{props.row.url}}</a> 
                </template>
                <template slot="actions" scope="props">
                    <ul class="icons-list" >
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-menu7"></i>
                            </a>

                            <ul class="dropdown-menu  dropdown-menu-right">
                                <li><a @click="editLink(props.row)" class="text-primary"  ><i class="icon-pencil3"></i> Edit</a></li>
                                <li><a @click="deleteLink(props.row)" class="text-danger" ><i class="icon-trash-alt" ></i> Delete</a></li>
                            </ul>
                        </li>
                    </ul>
                </template>
                
            </v-client-table>
        </div>
         
    </div>
    
    
    
</div>

</template>
<script>

import  ClientTable from 'vue-tables-2';

export default {
    props: ['project_id'],
    computed: {
      id: {
        get() {
          return this.project_id;
        },
        set() {

        }
      }
    },
    data() {

        return {
            loading: true,
             editMode: (localStorage.getItem('linksedit') =="false"? false: true),
             pid: this.$route.params.pid,
             form: new Form({
                 id: null,
                 project_id: this.$route.params.pid,
                 caption: null,
                 url: null,
                 
             }),
             links: [],
             columns: ['id', 'caption', 'link', 'created_at',, 'actions'],
             options: {
                headings: {
                    id: 'Id',
                    caption: 'Caption',
                    link: 'Link',        
                    created_at: 'Created',
                    actions: ''         
                  
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'
                },
           
                columnsClasses: {
                    id: 'w-70',
                    caption: 'w-150',
                    link: 'column-expanded',                
                    created_at: 'w-150',
                    
                    actions: 'text-right w-40 action'                   

                },

                skin: 'table-hover',
                texts: {
                    filter: ''
                }

            },
        
        }

    },
    created() {        
        this.getLinks(this.pid);
        var _this = this;
        bus.$on('refreshlink', function(){
            _this.getLinks(_this.pid);
        });
        bus.$on('edit', function(e){
            for(let property in e){
                _this.form[property] = e[property];
            }
        });
        

    },

    methods: {
        editToggle() {
            localStorage.setItem('linksedit', this.editMode);
        },
        onSubmit() { 
            this.form.project_id = this.id;
            this.form.post('/api/projects/'+this.id+'/links')
                     .then(({data})=>{
                         notice(this.form.notifications, 6000);
                         this.getLinks(this.pid);
                         this.form.reset()})
                     .catch(({error})=>{
                         notice(this.form.notifications, 6000);
                         })

        },
        getLinks(pid) {
            axios.get('/api/projects/'+pid+'/links')
                 .then(({data})=>{
                     this.links = data;
                     this.loading = false;
                  })
        }, 
  

        deleteLink(e) {          
         
            var yes = confirm('You are about to delete the link permanently. All system will not be able to access the link.');
            if(yes){  

                var form = new Form({
                    id: e.id,
                    project_id: e.project_id,
                    caption: e.caption,
                    url: e.url

                });             
                form.post("/api/projects/"+form.project_id+"/links/delete")
                    .then(({data})=>{
                        notice(form.notifications, 5000);
                        bus.$emit('refreshlink')})
                    .catch((error)=>{ 
                        notice(form.notifications, 5000);})               
            }

        },

        editLink(e) {
            bus.$emit('edit', e);
        },
        reset() {
            this.form.reset();
        }     

    }

}
</script>