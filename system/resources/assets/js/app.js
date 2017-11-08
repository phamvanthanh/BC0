"use strict";

import './bootstrap';
import Form from './core/Form';
import Router from './route';
import Acl from 'vue-acl';

window.capitalize = function(val) {
    if (!val) return '';
    return val.charAt(0).toUpperCase() + val.slice(1);
}


window.Form = Form;
window.router = Router;


window.bus = new Vue({});
Vue.use(Vuex);

const store = new Vuex.Store({ 
    state: {
        notifications: null,
        user: {},
        item: {
            label: '',
            name: ''
        }
    },

    mutations: {
        loadNotifications(state, payload) {
            state.notifications = payload;           
        },
        loadUser(state, payload) {         
            state.user = payload;
        },
        loadItem(state, payload) {
            state.item = payload;
        }        
    }
})

window.hasRole =  function(roles, name) {
    var i;
    for(i = 0; i <= roles.length; i++ ) {
        if(roles[i].name == name)
            return true;
        break;
    }
    return false;
}
if(sessionStorage.perms)
var perms = JSON.parse(sessionStorage.perms);
perms = perms || ['any'];
// console.log(perms)
Vue.use(Acl, { router: router, init: perms });
window.app =  new Vue({
    el: '#app',
    router,
    store,
    data: {
        loggedIn: false
    },
    created() {
        this.userOnline();
        
    },
    destroyed() {
		this.userOffline();
	},
	beforeCreate() {
		
        axios.get('/loggedInUser')
            .then(({data})=>{               
                this.$store.commit('loadUser', data);
                var access = data.roles.map(function(e){
                    return e.name;
                });
            
                this.$access(access);   
                sessionStorage.perms = JSON.stringify(access);  
                this.loggedIn = true;               
            })
            .catch((error)=>console.log(error));  

		
	},
    
      
    
    methods: {

        userOnline() {
			axios.post("/api/users/status/online");
				 	
		},
		userOffline() {
			axios.post("/api/users/status/offline");
				 	
		},
    }
   
});

window.notice = function($message, $timeout) {
    store.commit('loadNotifications', $message);
    setTimeout(function(){
        store.commit('loadNotifications', null);
    }, $timeout)
            
};

window.moment = require('moment');



Vue.component('status', {
    props: ['data'],
    computed: {
        isActive: function() {
            if(this.data.status == 'active' || this.data.status == 1)
                return true;
            return false;
        },
        stat: function() {
            if(this.data.status == 'active' || this.data.status == 'Active' || this.data.status == 1)
                return 'Active';
                
            return 'Deactive';
        } 
    },
    template: `<span :class="['label', isActive? 'label-success': 'label-default' ]">{{stat}}</span>`
})


require('./core/breadcrumbs');
 

Vue.component('window-heading2', {
  template: `<div class="breadcrumbs" >
                <div class="display-inline-block" style="height: 100%;  padding-right: 20px" >  
                        <a @click="back" class="pr-10"  ><i style="line-height: 46px"  class="icon-arrow-left8"></i></a>
                        <a @click="forward"><i style="line-height: 46px"  class="icon-arrow-right8"></i></a>
                </div>
                <div class="display-inline-block">  
                        <span class="display-block" ><vs-crumbs ></vs-crumbs></span>                    
                       
                </div>
             </div>           
            `,
  methods: {
      back() {
          router.go(-1);
      },
      forward() {
          router.go(1);
      }
  }
});
Vue.component('page-label', {
    template: '<span class="fs-16" style="line-height: 44px" >{{$route.meta.display}}</span>'
});

Vue.component('alter-subnav', {
    props: ['routes'],
    template: `<div>

            <router-link v-for="r in routes"  
                    :key="r.name" 
                    :to="{name: r.name, params: r.params}" 
                    class="btn btn-link btn-float has-text" >
                        <i :class="r.icon"></i>
                        <span>{{r.display}}</span>
            </router-link> 
        </div>
    `
});

import {ServerTable} from 'vue-tables-2';
Vue.use(ServerTable);

import {ClientTable} from 'vue-tables-2';
Vue.use(ClientTable);

window.pusher = new Pusher('806c86de02562f12daec', {
                cluster: 'ap1',
                encrypted: true
            });

window.d3 = require("d3"); 