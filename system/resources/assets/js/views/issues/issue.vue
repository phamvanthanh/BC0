<template>
<div class="panel panel-flat">
    <div :class="{loader:loading}"></div>
    <div :class="{hidden:loading}"  class="panel-heading">
        <div class="pull-left col-md-6">
            <span class="panel-title fs-18">{{issue.title}} - #{{issue.id}}</span><br>
             <span class="text-muted pull-left"  >         
                 <span  :class="['label mr-5 pt-5 pb-5', issue.status=='closed'?'label-success': 'label-warning']"><i class="icon-notification2"></i><span class="fs-15" v-if="issue" > {{issue.status | capitalize}}</span></span>{{issue.role}} opened {{issue.created_at}}
            </span>
        </div>
        <div class="heading-elements">
            <div class="pt-10 heading-btn-group">
                <router-link v-if="isOpener" :to="{name: $route.name+'.edit'}"  ><button class="btn btn-default" >Edit</button></router-link>
                <button v-if="isOpener && isOpen" @click="closeIssue"  class="btn btn-primary ml-10" >Close Issue</button>
                <button v-if="isOpener && !isOpen"  @click="openIssue" class="btn btn-danger ml-10" >Open Issue</button>        
                <router-link :to="{name: $route.meta.parentName+'.new'}" class="ml-10" ><button class="btn btn-success" >New Issue</button></router-link>
                
            </div>
        </div>
    </div>
    
    <div :class="{hidden:loading}" class="panel-body">
       <div id="issue">
            <ul class="pt-10">
                <li  v-html="issue.description">          
                 
                </li>
                <reply v-for="reply in issue.replies"
                    :reply="reply"
                    :id="issue.id"
                    :key="reply.id"
                    :job_id="job_id"
                >
                </reply>


                <li v-if="issue.status != 'closed'" class="list-group-item"   >
                    <form @submit.prevent="onSubmit" v-if="job_id" >
                        <div class="form-group">
                            <vue-editor v-model="form.reply" 
                                 useCustomImageHandler
                                @imageAdded="handleImageAdded"
                                :editorToolbar="editorCustomToolbar"
                            ></vue-editor>
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary" value="Comment" >
                        </div>
                    </form>
                </li>
                
            </ul>
       </div>
    </div>
</div>

</template>
<script>

import reply from './reply';
import { VueEditor } from 'vue2-editor';

export default {
    props: ['job_id'],
    data() {
        return {
            loading: true,
            issue: {},
            isOpener: false,        
            id: this.$route.params.iid,           

            form: new Form({
                id: null,
                issue_id: null,
                files: [],
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
    filters: {
        capitalize: function (value) {
            if (!value) return ''
            value = value.toString()
            return value.charAt(0).toUpperCase() + value.slice(1)
        }
    },
    components: {
        reply,
        VueEditor
    
    },
    created() {
        this.getIssue(this.id);
  
        let _this = this;
        bus.$on('refreshissue', function(){
            _this.getIssue(_this.id);
        })
          
    },

    watch: {
        id: function(val) {
            this.getIssue(val);
        },
        'form.reply': function(val, oldVal) {
          
            if(oldVal)
            if(oldVal.indexOf('<img src')> 0)
            {
                if(val)
                if(val.indexOf('<img src')<0)
                {


                    var start_pos = oldVal.indexOf('<img src="') + 11;
                    var end_pos = oldVal.indexOf('">',start_pos);
                    var url = oldVal.substring(start_pos,end_pos),
                    postData = {url: url};                     
                    axios.post('/api/jobs/issues/image/delete', postData)
                         .then(({data})=>{})
                         .catch((error)=>console.log(error));
                         
                }
            }
        }
    }, 

    computed: {
        isOpen: function(){
            if(this.issue.status != 'closed')
                return true;
            return  false;
        }
    },

    methods: {
        getIssue(id) {
            axios.get('/api/jobs/issues/'+id)
                 .then(({data})=>{
                     this.issue =  {
                             id: data.id,
                             title: data.title,
                             role: data.job.jobable_type == 'package'? 'Surveyor': data.job.jobable_type == 'group'? 'Controller': (data.job.jobable_type == 'project' && data.user_id == data.job.jobable.user_id)? 'Client' : 'Project Manager',  
                             description: data.description,
                             job_id: data.job_id,
                             status: data.status != 'closed'? 'open' : 'closed',
                             created_at: moment(data.created_at).startOf('hour').fromNow(),
                             updated_at: data.updated_at,
                             replies: data.replies.map(function(e){
                                 return {
                                     id: e.id,
                                     issue_id: e.issue_id,                                     
                                     job_id: e.job_id,
                                     user_id: e.user_id,
                                     reply: e.reply,
                                     created_at: moment(e.created_at).startOf('hour').fromNow(),
                                     role: e.job.jobable_type == 'package'? 'Surveyor': e.job.jobable_type == 'section'? 'Controller': (e.job.jobable_type == 'project' && e.user_id == e.job.jobable.user_id)? 'Client' : 'Project Manager',  
                                 }
                             })


                         };
                    this.isOpener = data.user_id == this.$store.state.user.id;
                    this.loading = false;
                    
                 })
                 .catch(({error})=>{
                     console.log(error);
                 })
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

            this.form.issue_id = this.id;
            this.form.job_id = this.job_id;

            this.form.post('/api/jobs/issues/'+this.id+'/reply')
                     .then(({data})=>{
                    
                         this.getIssue(this.id);
                         this.form.reset();
                     })
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);
                     })

        },

        closeIssue() {
            var form = new Form({
                id: this.issue.id,
                title: this.issue.title,
                job_id: this.issue.job_id,
                user_id: this.issue.user_id,
                description: this.issue.description,
                status: 'closed'
            });
            form.post('/api/issues')
                .then((data)=>{
                    this.getIssue(this.id);                   
                })
                .catch((error)=>{
                    
                    notice(form.notifications, 5000);
                })
        }, 

        openIssue() {
            var form = new Form({
                id: this.issue.id,
                title: this.issue.title,
                job_id: this.issue.job_id,
                user_id: this.issue.user_id,
                description: this.issue.description,
                status: 'open'
            });
            form.post('/api/issues')
                .then((data)=>{
                    this.getIssue(this.id);                   
                })
                .catch((error)=>{
                    
                    notice(form.notifications, 6000);
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

<style>
#issue img {
    max-height: 200px;
    max-width: 400px;
    display: block
}

</style>