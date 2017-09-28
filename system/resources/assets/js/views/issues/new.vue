<template>

<div class="panel panel-flat">
    <div class="panel-heading">
        <div class="pull-left col-md-6">            
            
        </div>
        <div class="heading-elements">
          
        </div>
    </div>
    
    <div class="panel-body">
       <div id="issue">
            <form @submit.prevent="onSubmit">
                <div class="form-group">
                   
                    <input name="title" v-model="form.title" placeholder="Issue title" class="form-control">                    
                </div>

                <div class="form-group">
                    <vue-editor v-model="form.description" 
                        useCustomImageHandler
                        @imageAdded="handleImageAdded"
                        :editorToolbar="editorCustomToolbar"
                        placeholder="Issue descriptions"
                    ></vue-editor>                             
                    
                </div>

                <div class="form-group">
                    <input type="submit" name="submit" value="Open Issue" class="btn btn-primary">            
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
    props: ['job_id'],
    
    data() {
        return {
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

    watch: {
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

            this.form.job_id = this.job_id;    
            this.form.post('/api/issues')
                .then((data)=>{                   
                    router.push({name: this.$route.meta.parentName+'.issue', params: {iid: data}});
                })
                .catch((error)=>{
                    
                    notice(this.form.notifications, 5000);
                })
        },
        cancel() {
            router.go(-1);
        },
        handleImageAdded(file, Editor, cursorLocation) {
          
            var formData = new FormData();
            formData.append('file', file);


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