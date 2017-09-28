<!--Project list -->
<template>               
        <tr >                            
            <td class="text-left" >{{bid.id}}</td>
           
           
            <td>{{bid.user.first_name}} {{bid.user.last_name}}
               
            </td>
            <td>
                {{bid.created_at}}
            </td>
            <td>
            </td>
            <td>
            </td>
            <td>
                <span v-if="bid.status == 'awarded'" class="label label-info" >Awarded</span>
            </td>
            <td class="text-right">
                <ul class="icons-list" >
                    <li class="text-primary-600" > 
                        <span v-if="bid.status == 'awarded'"><button @click="withHold" >withhold</button></span>                       
                        <span v-if="awardable" ><button  @click="award">Award</button></span>
                        <!--<router-link :to="{name: 'userroles', params: {uid: user.id}}"><i class="icon-user-tie"></i></router-link>-->
                    </li>
                          
                </ul>

                
            </td>
        </tr>      

</template>
<script>
    export default {
        data() {
            return {
                form: new Form({
                    id: null,
                    status: null
                })
            }
        },
        props: {          
                bid: {
                    id: null,
                    job: {
                        name: null
                    },
                    user: null

                },
                awardable: true,
                editMode: false,           
        },
        
        computed: {
         
        },
        methods: {
            award() {
                this.form.id = this.bid.id;
                this.form.status = 'awarded'
                this.form.post('/jobs/'+this.bid.job_id+'/bids')
                         .then(({data})=>{
                             console.log(data)})
                         .catch((error)=>{
                             console.log(error)})
            },
            withHold() {

            }
          
        }
       
        
    }
</script>