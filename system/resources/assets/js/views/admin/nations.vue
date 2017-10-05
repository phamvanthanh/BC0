<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>            
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                   
                </div>
            </div>
        </div>

    
    </div>

    <div class="content">
        <div :class="{loader:loading}"></div>   
        <div :class="{hidden:loading}" class="panel panel-flat">
            <div class="panel-heading">             
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
          
            <div class="panel-body">
                <div class="col-md-12" v-if="editMode">
                    <form @submit.prevent="onSubmit" method="post" >
                    
                        <div class="col-sm-2 pl-5">
                            <div class="form-group">
                                <label>Name: <span class="text-danger">*</span></label>
                                <input v-model="form.name" class="form-control">
                            </div>
                        </div>
                         <div class="col-sm-2">
                            <div class="form-group">
                                <label>Abbreviation: <span class="text-danger">*</span></label>
                                <input v-model="form.abbr" class="form-control">
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
                                <button @click="reset" type="button" class="btn btn-default form-control">Clear</button>
                            </div>
                        </div>
                    </form>
                     <div class="col-md-12 horizontal-divider mb-10"></div>
                </div>
                <div class="col-md-12">
                      <v-server-table 
                            ref="nation_table"
                            url="/api/admin/nations"                           
                            :columns="columns" 
                            :options="options">
                            <template slot="actions" scope="props">
                                 <ul class="icons-list" >
                                    <li class="dropdown" >
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                            <i class="icon-menu7"></i>
                                        </a>

                                        <ul class="dropdown-menu  dropdown-menu-right">
                                            <li><a @click="editNation(props.row)" class="text-primary" ><i class="icon-pencil3"></i> Edit</a></li>
                                            <li><a @click="copyNation(props.row)" class="text-primary"  ><i class="icon-copy3"></i> Copy</a></li>
                                            <li><a @click="deleteNation(props.row)" class="text-danger"  ><i class="icon-trash-alt"></i> Delete</a></li>
                                        </ul>
                                    </li>
                                </ul>

                            </template>
                      </v-server-table>
 
                </div>
            </div>           
         
        </div>
    
    </div>
 
    <notify :warns="$store.state.notifications"></notify>
</div>

</template>
<script>

import notify from './../../core/Notify';

export default {
  
    data() {
        return {
             loading: false,
             editMode: (localStorage.getItem('nationedit') =="false"? false: true),         
             form: new Form({
                 id: null,
                 name: null,
                 abbr: null              
                 
             }),
  
             columns: ['id', 'name', 'abbr', 'actions'],
             options: {

                headings: {
                    abbr: 'Abbr.',
                    actions:  ''
                },         
 
                columnsClasses: {                  
                    id: 'w-70',
                    name: 'column-expanded',
                    abbr: 'w-80',                  
                    actions: 'text-right w-40 action',
                },
                sortable: ['id', 'name', 'abbr']
             }
        
        }

    },
    components: {
        notify
    },

    created() {        
        // this.getNations(this.pid);
        // var _this = this;       
        
    },

 
    methods: {
        editToggle() {
            localStorage.setItem('nationedit', this.editMode);
        },
        onSubmit() { 
            this.form.post('/api/admin/nations')
                     .then(({data})=>{
                         this.$refs.nation_table.refresh();
                         notice(this.form.notifications, 5000);
                         this.form.reset();
                         
                         })
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);
                         })

        },
        // getNations() {
        //     axios.get('/api/admin/nations')
        //          .then((data)=>{
        //              this.nations = data.data;
        //              this.loading = false; })
        //          .catch((error)=>{
        //              console.log(error);
        //          })
        // },        

        editNation(e) {
            if(!this.editMode)
                this.editMode = true;
            for(let property in e){
                this.form[property] = e[property];
            }
           
        },
        copyNation(e) {
            this.editNation(e);
            this.form.id = null;
        },
        
        deleteNation(e) {

            this.form.id = e.id;          
            var yes = confirm('You are about to delete the role permanently. Deleting the role will disabled users assigned to the role.');
            if(yes){               
                this.form.post("/api/admin/nations/delete")
                        .then(({data})=>{
                            this.$refs.nation_table.refresh();
                            notice(this.form.notifications, 5000);
                            })
                        .catch((error)=>{ 
                            notice(this.form.notifications, 5000);
                        })               
            }          
        },
        reset() {
            this.form.reset();
        }
        

    }


}
</script>
