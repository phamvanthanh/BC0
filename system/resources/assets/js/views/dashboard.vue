<template>


    <dashboard :is="currentDashboard">
    </dashboard>

</template>

<script>
import pm from './dashboards/projectManager.vue';
import qtoc from './dashboards/qtoController.vue';
import qs from './dashboards/surveyor.vue';
import admin from './dashboards/admin.vue';
import client from './dashboards/client.vue';

    export default {
        props: ['role'],
        data() {
            return {

                
            }
            
        },
        computed: {
            currentDashboard: function() {
                var current = '';
                switch(this.role) {
                    case 'admin': 
                        current = 'admin';
                        break;
                    
                    case 'project_manager': 
                        current = 'pm';
                        break;

                    case 'surveyor': 
                        current = 'qs';
                        break;

                    case 'qto_controller': 
                        current = 'qtoc';
                        break;
                    case 'client': 
                        current = 'client';
                        break;
                    default:
                        break;
                }
                return current;
            } 
        },
        mounted() {
        
              
        },
        components: {
            pm,
            qtoc,
            qs,
            admin,
            client

        }
    }
</script>
