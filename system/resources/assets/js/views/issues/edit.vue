<template>

<div class="panel panel-flat">
    <div class="panel-heading">
        <div class="pull-left col-md-6">
            <span class="panel-title fs-18">Edit Issue</span><br>
            
        </div>
        <div class="heading-elements">
          
        </div>
    </div>
    
    <div class="panel-body">
       <div id="issue">
            <form @submit.prevent="onSubmit">
                <div class="form-group hidden">
                    <input name="Id" v-model="form.id" placeholder="Id" class="form-control hidden">
                    
                </div>
                <div class="form-group">
                    <input name="title" v-model="form.title" placeholder="Title" class="form-control">
                    
                </div>

                <div class="form-group">

                    <vue-editor v-model="form.description" 
                        useCustomImageHandler
                        @imageAdded="handleImageAdded"
                        :editorToolbar="editorCustomToolbar"
                    ></vue-editor>        
                    
                </div>
        
                <div class="form-group">
                    <input type="submit" name="submit" value="Save Issue" class="btn btn-primary">
                    <input type="button" @click.prevent="cancel" name="cancel" value="Cancel" class="btn btn-default">            
                    
                </div>

            </form>
       </div>
    </div>
</div>


</template>
<script>

import { VueEditor } from 'vue2-editor';

export default {
    
    
    data() {
        return {
           
            id: this.$route.params.iid,

            form: new Form({
                id: null,
                job_id: null,              
                title: null,
                files: null,
                description: null
            }),
           
            deleteImageUrls: [],
            uploadedUrls:[],
            editorCustomToolbar: [
                ['bold', 'italic', 'underline', 'strike', { 'align': [] },
                { 'list': 'ordered'}, { 'list': 'bullet' },
                'image', 'code-block']
           ]
        }
    },
    components: {
        VueEditor
    },
     created() {
        this.getIssue(this.id);
    },

    watch: {
        id: function(val) {
            this.getIssue(val);
        },
        
        'form.description': function(val, oldVal) {
  
            if(oldVal)
            if(oldVal.indexOf('<img src')> 0)
            {
                if(val)
                if(val.indexOf('<img src')<0)
                {
                    
                    var start_pos = oldVal.indexOf('<img src="/') + 11;
                    var end_pos = oldVal.indexOf('">',start_pos);
                    var url = oldVal.substring(start_pos,end_pos);                   
                    this.deleteImageUrls.push(url);                  
                         
                }
            }
        }
    }, 

    methods: {
        onSubmit() {

             if(this.deleteImageUrls.length > 0) {
                var images = this.deleteImageUrls, i;

                for(i=0; i< images.length; i++){
                
                    if(this.form.description.indexOf('<img src="/'+images[i]) <= 0) {                 
                         var postData = {url: images[i]};                     
                         axios.post('/api/jobs/issues/image/delete', postData)
                              .then(({data})=>{})
                              .catch((error)=>console.log(error));

                    }
                  
                }
                this.deleteImageUrls = [];

            }
     
            this.form.post('/api/issues')
                .then(({data})=>{
                    router.go(-1);
                })
                .catch(({error})=>{
                    notice(this.form.notifications, 5000);
                })
        },

        getIssue(id) {
            axios.get('/api/jobs/issues/'+id)
                 .then(({data})=>{
                     this.form.id =  data.id;
                     this.form.job_id = data.job_id;
                     this.form.title = data.title;
                     this.form.description = data.description;
                 })
                 .catch(({error})=>{
                     console.log(error);
                 })
        },  
        cancel() {
            router.go(-1);
        },      

        handleImageAdded(file, Editor, cursorLocation) {
          
            var formData = new FormData();
            formData.append('file', file);
            console.log('trigger');

            axios({
            url: '/api/jobs/issues/'+this.id+'/reply/file',
            method: 'POST',
            data: formData
            })
            .then((result) => {
              
                let url = result.data.url  // Get url from response
                Editor.insertEmbed(cursorLocation, 'image', url);
                this.uploadedUrls.push(url.slice(1));
            })
            .catch((err) => {
            console.log(err);
            })
         
        },
        
    }
}

</script>