<template>
<div>
    <lines
        :job="info">
    </lines>
    <itemProgresses
        :job="info">
    </itemProgresses>
    <stacked-packages 
        :job="info">
    </stacked-packages>
</div>
</template>
<script>
import itemProgresses  from './../../reports/item-progresses';
import lines  from './../../reports/lines';
import stackedPackages  from './../../reports/stackedpackages';

export default {
    props: ['info'],
    
    
    components: {
       itemProgresses,
       lines,
       stackedPackages
    },

}
</script>