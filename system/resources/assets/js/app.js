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

Vue.use(Acl, { router: Router, init: 'any' });
window.app =  new Vue({
    el: '#app',
    router,
    store,
    data: {
        loggedIn: false
    },
	beforeCreate() {
		
        axios.get('/loggedInUser')
            .then(({data})=>{               
                this.$store.commit('loadUser', data);
                var access = data.roles.map(function(e){
                    return e.name;
                });
         
                this.$access(access);     
                this.loggedIn = true;               
            })
            .catch((error)=>console.log(error));  

		
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

import {ServerTable} from 'vue-tables-2';
Vue.use(ServerTable);


import {ClientTable} from 'vue-tables-2';
Vue.use(ClientTable);


 