<template>
    <div>

        <b-alert
        :show="dismissCountDown"
        dismissible
        :variant="variant"
        @dismissed="dismissCountDown=0"
        @dismiss-count-down="countDownChanged">
            <p>{{msg}}</p>
        </b-alert>

        <div class="login bg-light">
            <p v-if="state.loginError">{{ state.loginError }}</p>
            <p v-if="state.loginSuccessful">Login Successful</p>

            <form @submit.prevent="loginSubmit">
                <b-form-group id="input-group-1"
                label="Email address:"
                label-for="input-1"
                description="We'll never share your email with anyone else.">
                    <b-form-input id="input-1"
                        v-model="email"
                        type="email"
                        required
                        placeholder="Enter email">
                    </b-form-input>
                </b-form-group>

                <b-form @submit.stop.prevent>
                    <label >Password</label>
                    <b-input type="password" id="text-password" aria-describedby="password-help-block" v-model="password"></b-input>
                </b-form>

                <b-button type="submit" @click="showAlert" v-on:click="loginSubmit" variant="outline-primary">Login</b-button>
            </form>

        </div>
    </div>
</template>

<script>

  import Vue from 'vue'
  import Vuex from 'vuex'
  import axios from 'axios'
  import { mapState } from 'vuex';
  import { mapActions } from 'vuex';
  Vue.use(Vuex);

export default {
  name: 'Login',
  mutations: {
    loginStart: state => state.loggingIn = true,
    loginStop: (state, errorMessage) => {
      state.loggingIn = false;
      state.loginError = errorMessage;
      state.loginSuccessful = !errorMessage;
    }
  },
  data() {
    return {
      email: '',
      password: '',
      state: {
        loggingIn: false,
        loginError: null,
        loginSuccessful: false
      },
      dismissSecs: 3,
      dismissCountDown: 0,
      showDismissibleAlert: false,
      TloginSuccessful: "Login successful",
      TloginError: "Login error",
      msg: "",
      variant: "",
        isLogin: false
    }
  },
  computed: {
    ...mapState([
      'loggingIn',
      'loginError',
      'loginSuccessful'
    ])
  },
  methods: {
    ...mapActions([
      'doLogin'
    ]),
    loginSubmit() {
      if (!this.validEmail(this.email)) {
        this.setError();
        return ;
      }
      axios.get('https://reqres.in/api/login')
              .then(() => {
                this.setSuccesful();
                this.isLogin = true;
                this.$router.push('/dashboard')
              })
              .catch(error => {
                this.setError();

                console.log(error)
              })
    },
    validEmail:function(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    },
    countDownChanged(dismissCountDown) {
      this.dismissCountDown = dismissCountDown
    },
    showAlert() {
      this.dismissCountDown = this.dismissSecs
    },
    setSuccesful() {
      this.msg = this.TloginSuccessful;
      this.variant = "success"
    },
    setError() {
      this.msg = this.TloginError;
      this.variant = "danger"
    }
  }
}
</script>

<style scoped>
.login {
    border: 1px solid black;
    border-radius: 5px;
    padding: 1.5rem;
    width: 300px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    overflow: hidden;
    .container-loading {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: rgba(0, 0, 0, .3);
        img {
            width: 2rem;
            height: 2rem;
        }
    }
    form {
        display: flex;
        flex-flow: column;
        *:not(:last-child) {
            margin-bottom: 1rem;
        }
        input {
            padding: .5rem;
        }
        button {
            padding: .5rem;
            background-color: lightgray;
            border: 1px solid gray;
            border-radius: 3px;
            cursor: pointer;
            &:hover {
                background-color: lightslategray;
            }
        }
    }
}
</style>
