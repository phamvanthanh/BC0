<template>
    <li class="issue-reply list-group-item">
        <div class="reply-heading">
            <span class="fs-14 ">{{reply.role}} </span><span class="text-muted"> {{reply.created_at}}</span><a v-if="reply.user_id == $store.state.user.id"
                @click="edit" class="edit-reply pull-right"><i class="icon-pencil3"></i></a>
            <p v-if="!isEditReply" class="pt-10, pl-20" v-html="reply.reply"> </p>
        </div>
        <div v-if="isEditReply">
            <form @submit.prevent="onSubmit">
                <div class="form-group">
                    <!--<textarea name="reply" v-model="form.reply" rows="3" class="form-control"></textarea>-->
                    <vue-editor v-model="form.reply" useCustomImageHandler @imageAdded="handleImageAdded" :editorToolbar="editorCustomToolbar"></vue-editor>
                </div>
                <div class="form-group">                  
                    <input type="submit" value="Save comment" class="btn btn-primary">
                    <button @click.prevent="cancel" class="btn btn-default">Cancel</button>
                </div>
            </form>
        </div>
    </li>

</template>

<script>
import { VueEditor } from 'vue2-editor';

export default {
    props: ['reply', 'id', 'job_id'],
    data() {
        return {
            isEditReply: false,
            form: new Form({
                id: null,
                issue_id: null,
                job_id: null,
                reply: null,
               
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
    created() {
        let _this = this;
        bus.$on('openreply', function() {
            _this.cancel();
        })
    },
    components: {
         VueEditor
    },
    watch: {
        'form.reply': function(val, oldVal) {
            console.log(val, oldVal);
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
        edit() {
            bus.$emit('openreply');

            this.isEditReply= true;

            for(let property in this.reply){
    
                this.form[property] = this.reply[property];
            }

        },
        cancel() {
         
            this.isEditReply = false;
            this.form.reset();
            var images = this.uploadedUrls, i;
            for(i=0; i < images.length; i++){
               
                //  if(this.form.reply.indexOf('<img src="/'+images[i]) == 0) {
                        var postData = {url: images[i]};                     
                        axios.post('/api/jobs/issues/image/delete', postData)
                            .then(({data})=>{})
                            .catch((error)=>console.log(error));

                //  }                
            }
            this.uploadedUrls = [];
           

        },
        
        onSubmit() {
           
            if(this.deleteImageUrls.length > 0) {
                var images = this.deleteImageUrls, i;

                for(i=0; i< images.length; i++){
                    if(this.form.reply.indexOf('<img src="/'+images[i]) == 0) {
                         var postData = {url: images[i]};                     
                         axios.post('/api/jobs/issues/image/delete', postData)
                              .then(({data})=>{})
                              .catch((error)=>console.log(error));

                    }
                  
                }
                this.deleteImageUrls = [];

            }

            this.form.post('/api/jobs/issues/'+this.id+'/reply')
                     .then(({data})=>{
                         this.isEditReply = false;
                         bus.$emit('refreshissue');
                         this.form.reset();
                
                     })
                     .catch((error)=>{
                         notice(this.form.notifications, 5000);
                     })
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
                formData = null;
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