
import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from './views/Dashboard';
import Login from './views/Login'
import Register from './views/Register'

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            name: 'login',
            component: Login
        }, {
            path: '/dashboard',
            name: 'dashboard',
            component: Dashboard
        }, {
            path: '/register',
            name: 'register',
            component: Register
        }

    ]
})
