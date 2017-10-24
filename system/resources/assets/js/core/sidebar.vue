<template>
<div  class="vertical-menu">

  <div class="menu-list">
    <router-link v-if='$can("superuser|surveyor|qto_controller|project_manager")' to="/myjobs">My Jobs</router-link>
    <router-link v-if='$can("superuser|surveyor|qto_controller|project_manager|project_directors|sales_manager")' to="/bids">My Bids</router-link>
    <router-link v-if='$can("superuser|surveyor|qto_controller|project_manager|project_directors|sales_manager")' to="/jobs">Jobs</router-link>
    <router-link v-if='$can("client")' to="/clients/projects">Projects</router-link>
    <router-link  to="/messenger">Messages</router-link>
    <router-link v-if='$can("surveyor|qto_controller|project_manager|project_director|superuser")' title="Forms" to="/forms" >Forms</router-link>
    <span v-if='$can("superuser|project_director|sales_manager")' >DESK</span>
    <router-link v-if='$can("superuser|project_director|sales_manager")' to="/desk/projects">Projects</router-link>    
    <router-link v-if='$can("superuser|project_director|sales_manager")' to="/desk/jobs">Jobs</router-link>
    <router-link v-if='$can("superuser|project_director|sales_manager")' to="/desk/clients">Clients</router-link>
    <router-link v-if='$can("superuser|sales_manager")' to="/desk/leads">Leads</router-link>
    <router-link v-if='$can("superuser|project_director|sales_manager")' to="/desk/wbs">Wbs</router-link>  
    <span v-if='$can("superuser|admin")' >ADMIN </span>
    <router-link v-if='$can("superuser|admin")' to="/admin/users">Users</router-link>
    <router-link v-if='$can("superuser|admin")' to="/admin/roles">Roles</router-link>
    <router-link v-if='$can("superuser|admin")' to="/admin/permissions">Permissions</router-link>
    <router-link v-if='$can("superuser|admin")' to="/admin/nations">Nations</router-link>
    <router-link v-if='$can("superuser|admin")' to="/admin/forms">Forms</router-link>

    
  </div>
    
  
</div>

</template>
<script>


export default {

}
</script>
<style>

</style>
