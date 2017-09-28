import VueRouter from 'vue-router';

let routes = [
    {
        path: '/',
        component: require('./views/dashboard.vue')
    }, {
        path: '/jobs',
        component:require('./views/jobs/jobs.vue')
    }, {
        path: '/jobs/:id',
        name:'jobInfo',
        component:require('./views/jobs/info.vue')
    },
    
    
     {
        path: '/projects',
      
        component: require('./views/pm/projects.vue'),
        children: [
            {
             path: '',
             name: 'list',
             component: require('./views/pm/projects/list')
            }, 
        ]
    },
    {
        path: '/projects/new',
        name: 'newproject',
        component: require('./views/pm/new')
    }, {
        path: '/projects/:pid',
        name: 'info',
        component: require('./views/pm/info')
    }, {
        path: '/projects/:pid/pwbs',
        name: 'pwbs',
        component: require('./views/pm/pwbs')
    }, {
        path: '/projects/:pid/groups',      
        component: require('./views/pm/groups.vue'),
        children: [
            {
                path: '',
                name: 'groups',
                component: require('./views/elements/grouplist')
            }, {
                path: ':gid',
                name: 'group',
                component: require('./views/elements/group')
            }, 
        ]
    },{
        path: '/projects/:pid/packages',
        name: 'packages',
        component: require('./views/pm/packages')
    }, {
        path: '/projects/:pid/markdowns',
        name: 'markdowns',
        component: require('./views/pm/markdowns')
    }, {
        path: '/projects/:pid/unitify',
        name: 'unitify',
        component: require('./views/pm/unitify')
    }, {
        path: '/projects/:pid/reports',
        name: 'reports',
        component: require('./views/pm/reports')
    }, {
        path: '/projects/:pid/docs',
        name: 'docs',
        component: require('./views/pm/docs')
    }, {
        path: '/projects/:pid/doclinks',
        name: 'doclinks',
        component: require('./views/pm/doclinks')
    }, {
        path: '/admin/roles',
        name: 'roles',
        component: require('./views/admin/roles/roles')
    }, {
        path: '/admin/users',
        name: 'users',
        component: require('./views/admin/users/users')
    }, {
        path: '/admin/users/:uid',
        name: 'userroles',
        component: require('./views/admin/userroles/userroles')
    },  {
        path: '/admin/permissions',
        name: 'permissions',
        component: require('./views/admin/permissions/permissions')
    },  
    {
        path: '/jobs',
       
        component: require('./views/jobs/jobs'),
        children: [
            {
                path: '',
                name: 'jobs',
                component: require('./views/elements/jobs/list')
            }, {
                path: ':jid',                
                component: require('./views/elements/jobs/job'),
                children: [
                    {
                        path: '',
                        name: 'jwbs',
                        component: require('./views/elements/jobs/jwbs'),
                    }, {
                        path: 'bids',
                        name: 'bids',
                        component: require('./views/elements/jobs/bids'),
                    }, {
                        path: 'quantity',
                        name: 'quantity',
                        component: require('./views/elements/jobs/quantity')
                    }, {
                        path: 'audit',
                        name: 'audit',
                        component: require('./views/elements/jobs/audit')
                    }
                ]
            }, 
            //  {
            //     path: ':jid/bids',
            //     name: 'bids',
            //     component: require('./views/elements/jobs/bids')
            // }, 
            

        ]
    }, 
     {
        path: '/test',
        name: 'test',
        component: require('./views/pm/test')
    }
]
export default new VueRouter({
    routes,
    linkActiveClass: 'is-active'
    
   
});