<template>
<div class="main-content">
    <router-view>
      
            <vs-crumbs slot="crumbs"></vs-crumbs>
      
    </router-view>
   
</div>
</template>
<script>
    require ('./breadcrumbs.vue');

</script>