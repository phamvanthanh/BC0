<template>
<div>
    <lines
        :job="job">
    </lines>
    <itemProgresses
        :job="job">
    </itemProgresses>
    <stacked-packages 
        :job="job">
    </stacked-packages>
</div>
</template>
<script>
import itemProgresses  from './../../../reports/item-progresses';
import lines  from './../../../reports/lines';
import stackedPackages  from './../../../reports/stackedpackages';

export default {
    props: ['job'],
    
    components: {
       itemProgresses,
       lines,
       stackedPackages
    },

}
</script>