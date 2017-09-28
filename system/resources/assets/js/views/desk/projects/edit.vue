<template>
    <a class="fa fa-edit" :href="edit(data.id)">Edit</a>
</template>
<script>
    export default {
        props:['data'],
    }
</script>