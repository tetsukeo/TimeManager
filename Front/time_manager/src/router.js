
    import Vue from 'vue'
    import Router from 'vue-router'
    import Dashboard from './views/Dashboard';
    import Login from './views/Login'

    Vue.use(Router);

    export default new Router({
        routes : [
            {
                path: '/dashboard',
                name: 'dashboard',
                component: Dashboard
            },
            {
                path: '/login',
                name: 'login',
                component: Login
            }
        ]
    })
