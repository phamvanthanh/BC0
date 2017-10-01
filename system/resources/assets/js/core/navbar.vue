<template>
  <nav class="navbar">
    <div class="container-fluid">
      <div class="navbar-header">
        <a href="https://breakcost.com" class="navbar-brand" style="font-size: 26px; font-weight: 600">
          <span class="pr-0" style="color:#3097D1 !important">BREAK</span><span class="pl-0" style="color:#ff3860 !important">COST</span>

        </a>
      </div>

      <ul class="nav navbar-nav navbar-right">

        <li>
          <a href="#"></a>
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
              <!--<a href="/mysettings" >My Settings</a>-->
            </li>
            <li>
              <!--<a href="#"
                              onclick="event.preventDefault();
                                          document.getElementById('logout-form').submit();">-->
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
        loading: false
    }

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
        $(e.target).toggleClass('active');;
    },
    logout() {
      axios.post('/logout')
           .then((data)=>{
             this.loading = true;
             location.reload();
           })
           .catch(error=>{
             location.reload();
             console.log(error);
              
           })
    }

   
  
  }
}


</script>
<style>
  #nav-dropdown1 {
    margin-top: -2px;
  }
</style>