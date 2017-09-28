<template>
<span class="rating">
    <i v-for="n in length"
      :class="[n <= value? 'icon-star-full2 rated-star' : 'icon-star-empty3 text-muted']">
    </i>
</span>
</template>
<script>
export default {
    props: ['length', 'value'],
    
}
</script>
<style>
.rated-star {
    color: #efc20f;
}
.rating i {
    padding-right: 3px;
    font-size: 12px;
}
span.rating {
    cursor: pointer;
}
</style>