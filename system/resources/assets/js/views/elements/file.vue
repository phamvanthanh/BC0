<template>
    <tr>
        <td>
            #
        </td>
        <td>
            {{file.name}}

        </td>
        <td>
            {{file.created_at}}
        </td>
        <td>
            <span v-if="editMode">
                <a v-on:click="deleteFile" class="text-danger-600" ><i class="icon-trash"></i></a>
            </span>

        </td>
    </tr>
</template>
<script>
export default {
    props: {
        file: {
            id: null,
            name: null,
            path: null,
            folder_id: null,
            created_at: null,
        },       
        editMode: true
        
    },
    data() {
        return {
            form: new Form({
                id: null,      
                path: null,
            
            }),
        }
    },
    methods: {
        deleteFile() {
            let yes = confirm('Your are deleting this file permanently. You and authorized users will no longer be able to access to this file.');
            if(yes){
                this.form.id = this.file.id;
                this.form.path = this.file.path;
                this.form.post('/projects/folders/'+this.file.folder_id+'/files/delete')
                        .then(({data})=>{
                            this.formNotify(); 
                            bus.$emit('refreshfiles')})
                        .catch(({error})=>{
                            this.formNotify()})

            }     

        },
        formNotify() {
            this.$store.commit('loadNotifications', this.form.notitifcations);
        }

    }
}
</script>