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
         
        <div  class="panel panel-flat">
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
                <form @submit.prevent="onSubmit" method="post"  v-if="editMode" >
                    <div class="row">
                        <div class="col-sm-2 pl-0">
                            <div class="form-group">
                                <label>Code: <span class="text-danger">*</span></label>
                                <input v-model="form.code" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>Name: <span class="text-danger">*</span></label>
                                <input v-model="form.name" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>File: <span class="text-danger">*</span></label>
                                <input name="form.fileUpload" @change="onFileChange" id="file-input" class="" type="file" >
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 pl-0">
                            <div class="form-group">
                                <label>Note: <span class="text-danger"></span></label>
                                <input v-model="form.note" class="form-control">
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
                                <button @click="form.reset()" type="button" class="btn btn-default form-control">Clear</button>
                            </div>
                        </div>
                    </div>
                    
                </form>
                <div class="row horizontal-divider mb-10 "></div>               
                <div class="row">
                      <v-server-table 
                            ref="form_table"
                            url="/api/forms" 
                            :columns="columns" 
                            :options="options">
                            <template slot="name" scope="props">
                                <a :href="props.row.path" download>{{props.row.name}}</a>
                            </template>

                            <template v-if="$can('admin|superuser')" slot="actions" scope="props">
                                 <ul class="icons-list" >
                                    <li class="dropdown" >
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                            <i class="icon-menu7"></i>
                                        </a>
                                        <ul class="dropdown-menu  dropdown-menu-right">
                                            <li><a @click="editFile(props.row)" class="text-primary" ><i class="icon-pencil3"></i> Edit</a></li>
                                             <li><a @click="copyFile(props.row)" class="text-primary" ><i class="icon-copy3"></i> Copy</a></li>
                                            <li><a @click="deleteFile(props.row)" class="text-danger"  ><i class="icon-trash-alt"></i> Delete</a></li>
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

import FileUpload from 'vue-simple-upload/dist/FileUpload';
import notify from './../../../core/Notify';
export default {
  
    data() {
        return {
          
             editMode: (localStorage.getItem('formedit') =="false"? false: true),
             files: [],
             form: new Form( {   
                 id: null,          
                 code: null,
                 name: '',
                 note: '',
                 path: null,
                 fileUpload: null,                             
                 
             }),
             formData: new FormData({

             }),
             nations: [],
             columns: ['id', 'code', 'name', 'note', 'actions'],
             options: {

                headings: {
                    actions:  ''
                },

                columnsClasses: {                  
                    id: 'w-70',
                    code: 'w-80',
                    name: 'column-expanded',
                    note: 'w-200',
                    actions: 'text-right w-40 action',
                },
                sortable: ['id', 'code', 'name', 'note']

             }
        
        }

    },
    components: {
         'fileupload': FileUpload,
         notify
    },
 
    methods: {
        editToggle() {
            localStorage.setItem('formedit', this.editMode);
        },
        onSubmit() { 
		    this.formData.append('code', this.form.code);
            this.formData.append('name', this.form.name);
            this.formData.append('note', this.form.note);
            if(this.form.id)
                this.formData.append('id', this.form.id);
            
            axios.post('/api/forms', this.formData)
                 .then(response=>{      
                     this.$refs.form_table.refresh();              
                     this.form.reset();
                     $("#file-input").val('');
                     notice( {
                         status: response.status,
                         statusText: response.statusText,
                         data: response.data
                     }, 6000);

                     this.formData = new FormData();
                     
                 })
                 .catch(error=>{
                  
                     notice({
                         status: error.response.status,
                         statusText: error.response.statusText,
                         data: error.response.data
                     }, 6000);
                 })
        },
  
        onFileChange(e) {
            this.formData.delete("file");
            if(this.validateFile(e.target)) {
                let files = e.target.files || e.dataTransfer.files
                if (!files.length) {
                    return;
                };

                this.file = files[0];			
        
                this.formData.append('file', this.file);  
            }

            return;
             

        },
        editFile(e) {         
            for(let property in e){
                this.form[property] = e[property];
            }
        },
        copyFile(e) {
            this.editFile(e);
            this.form.id = null;
        },
        deleteFile(e) {
            let form = new Form({
                id: null
            });

            for(let property in e){
                form[property] = e[property];
            }
            form.post('/api/forms/delete')
                     .then((data)=>{
                         this.$refs.table_form.refresh();
                         notice(form.notifications);
                     })
                     .catch((error)=>{
                         notice(form.notifications);
                     })

        },        
      
        validateFile(oInput) {
            
            var _validFileExtensions = [".xls", ".xlsx", ".pdf"];  
            if (oInput.type == "file") {
                var sFileName = oInput.value;
                if (sFileName.length > 0) {
                    var blnValid = false;
                    for (var j = 0; j < _validFileExtensions.length; j++) {
                        var sCurExtension = _validFileExtensions[j];
                        if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                            blnValid = true;
                            break;
                        }
                    }
                    
                    if (!blnValid) {
                        this.formData.delete("file");
                        notice({
                            status: 422,
                            statusText: 'File format is not invalid',
                            data: ['File format is not valid. Please upload file with extensions: .xls, .xlsx or .pdf']
                        }, 8000);
                        $(oInput).val('');
                        return false;

                    }
                }
            }
            return true;
        }
    }


}
</script>
