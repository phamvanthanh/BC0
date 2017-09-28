<script>

export default {
    props: {
        node: null
    },
    data: function (){
        return {
            open: true,      
        
        }
    },
    computed: {
        isFolder: function() {
        return this.node.children && this.node.children
        }
    },
    methods: {
        toggle: function(){
        if(this.isFolder){
            this.open = !this.open
        }
        },
        clickNode: function(){   
        if(!this.isActive)
            this.selectNode();
        else
            this.deselectNode();
        }, 
    }  
    
};

</script>