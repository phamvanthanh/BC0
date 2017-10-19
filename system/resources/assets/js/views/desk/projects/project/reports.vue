<template>
<div>
    <lines
        :job="job">
    </lines>
    <itemProgresses
        :job="job">
    </itemProgresses>
    <grid 
        :job="job">
    </grid>
</div>
</template>
<script>
import itemProgresses  from './../../../reports/item-progresses';
import lines  from './../../../reports/lines';
import grid  from './../../../reports/grid';

export default {
    props: ['job'],
    
    components: {
       itemProgresses,
       lines,
       grid
    },

}
</script>