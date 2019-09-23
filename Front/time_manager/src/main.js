import Vue from 'vue';
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';
import router from './router';
import store from './store';
import Vuex from 'vuex';
import App from './App';

Vue.use(VueRouter);
Vue.use(BootstrapVue);
Vue.use(Vuex);

require('./assets/styles.css');
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app');
