<template>
  <nav class="navbar">
    <div class="container-fluid">
      <div class="navbar-header display-flex">
        <a href="https://breakcost.com" class="navbar-brand" style="font-size: 26px; font-weight: 600">
          <span class="pr-0" style="color:#3097D1 !important">B</span>

        </a>        
         <window-heading2></window-heading2> 
      </div>

      <ul class="nav navbar-nav navbar-right">

        <li>
          <router-link  to="/messenger">
              <i class="icon-bubble2"></i>
              <span id="msg-count" v-if="unreads > 0" class="badge bg-warning fs-10">{{unreads}}</span>
          </router-link>
       
        </li>
        <li class="dropdown">

          <a href="/" class="dropdown-toggle" data-toggle="dropdown" id="dropdown1">
            <img src="" alt="">

            <span>{{user.first_name}}</span>

            <i class="caret"></i>
          </a>

          <ul class="dropdown-menu" id="nav-dropdown1" aria-labelledby="dropdown1">

            <li>
              <a href="#" @click.prevent="stay" class="accordion  has-ul">

                <span>Your Roles</span>
              </a>
              <ul class="panel accordion-content hidden pb-0 mb-0">
                <li v-for="role in user.roles"><a href="#">{{role.display_name}}</a></li>

              </ul>
            </li>
            <li>
              <router-link to="/mysettings">My Settings</router-link>            
            </li>
            <li>

              <a @click="logout">
                    Logout
              </a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </nav>


</template>

<script>
export default {
  data() {
    return {
        loading: false,
        unreads: 0
    }

  },
  created() {
    this.countAllUnreads();
    bus.$on('readmessages',()=>{
       this.countAllUnreads();
    });
    this.messageCountChannel();
  },
  computed : {
    user: function() {
      return this.$store.state.user;
     }
  },
  methods: {
    stay(e) {      
        e.stopPropagation();
        var x = $('ul.panel.accordion-content').toggleClass('hidden');
        $(e.target).toggleClass('active');
    },
    countAllUnreads() {
         axios.get('/api/messages/countallunreads')
               .then(({data})=>this.unreads = data)
               .catch((error)=>console.log(error));
    },
    messageCountChannel() {
      var uid = this.$store.state.user.id;
      var allmessages = pusher.subscribe('message_to_'+uid);
       allmessages.bind('system\\Events\\NewMessage',(data)=>{
           
            this.countAllUnreads();    
       }); 

    },
    logout() {  

      var masterpage = document.getElementById("overlay");
      masterpage.className = "overlay";
			axios.post("/api/users/status/offline")
           .then(()=>{
                  axios.post('/logout')
                    .then(()=>{
                      this.loading = true;
                      location.reload();
                    })
                    .catch(error=>{
                      location.reload();
                      console.log(error);                        
                    })
           })
	

    }

   
  
  }
}


</script>
<style>
  #nav-dropdown1 {
    margin-top: -2px;
  }
  #msg-count {
    position: absolute;
    top: 15%;
    left: 60%
  }
</style>