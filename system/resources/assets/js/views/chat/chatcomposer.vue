<template>
<form @submit.prevent="submit"  method="post" v-if="contact.recipient_id" >
    <div class="chat-composer" >
        <input class="msg-input"  name="message"  v-model="form.message"  rows="2" cols="1" placeholder="Enter your message...">
            <a class="chat-actions" @click="uploadFile" ><i class="icon-image4"></i></a>												
        </input>
        <input name="fileUpload" @change="onFileChange" id="file-input" class="chat-actions hidden" type="file" >									
        <button type="submit" class="btn btn-primary">Send</button>
    </div>
    <div class="row">
        <div class="col-xs-6">
            <ul class="icons-list icons-list-extended mt-10">
            </ul>
        </div>								
    </div>
</form>
</template>
<script>
export default {
    props: ['contact'],

    data() {
        return {
            form: new Form({
                message: null,
                recipient_id:  null
            })
        }
    },
    methods: {
        uploadFile() {

        },
        onFileChange() {
            
        },
        submit() {
            var date = new Date();
            var id = Date.parse(date);   
            if(this.form.message != null && this.form.message != '')   {      
                var message = {
                    id: id,
                    message: this.form.message,
                    sender_id: this.contact.sender_id,
                    recipient_id: this.contact.recipient_id,
                    sender_name: this.$store.state.user.first_name + ' '+ this.$store.state.user.last_name
                };
                bus.$emit('newmessage', message);

                this.form.recipient_id = this.contact.recipient_id;
                this.form.post('/api/messages')
                        .then(()=>{
                            this.form.reset();                        
                        })
                        .catch(()=>{
                            bus.$emit('messagenotsent', message);
                            this.form.reset();
                        });
            }
        }
        
    }
}

</script>