<!--Project list -->
<template>               
        <tr> 
                           
            <td>{{job.id}}</td>
            <td><router-link :to="{name: 'jwbs', params: {jid: job.id} }">{{job.jobable.name}}</router-link></td>
            <td>{{job.jobable_type}}</td>
            <td>{{job.from_date}} - 
                {{job.to_date}}
            </td>
            <td><router-link :to="{name: 'bids', params: {jid: job.id}}">  <span :class="[job.bids.length > 0? 'label-primary': 'label-default', 'label' ]">{{job.bids? job.bids.length: 0}}</span></router-link> </td>
          
                                    
            <td><span :class="[job.status == 'active'? 'label-success': job.status == 'suspended'? 'label-warning' : 'label-default', 'label' ]" >{{job.status}}</span></td>

            <td class="text-right">
                <ul class="icons-list" >
                    <li class="text-primary-600" >
                        <!--<router-link :to="{name: 'userroles', params: {uid: user.id}}"><i class="icon-user-tie"></i></router-link>-->
                    </li>
                    <li class="text-primary-600" v-if="editMode" >
                        <a v-on:click="editJob"><i class="icon-pencil7"></i></a>
                    </li>                
                </ul>

                
            </td>
        </tr>      

</template>
<script>
    export default {
      
        props: {          
                job: {
                    id: null,
                    jobable: {
                        name: null
                    },
                    jobable_type: null,
                    role_id: null,
                    from_date: null,
                    to_date: null,
                    status: null,
                    bids: [],

                },
                editMode: false,           
        },
        computed: {
            isActive() {
                return this.job.status == 1;
            }
        },
        methods: {
            editJob() {
                bus.$emit('editjob', this.job);
            }
        }
       
        
    }
</script>