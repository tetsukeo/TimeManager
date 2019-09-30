<template>
  <div class="login-wrapper border border-light">
    <form class="form-signin">
      <h2 class="form-signin-heading">Register</h2>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <label for="rInputEmail" class="sr-only">Email address</label>
      <input
        v-model="rEmail"
        type="email"
        id="rInputEmail"
        class="form-control"
        placeholder="Email address"
        required
      />
      <label for="rInputUsername" class="sr-only">Username</label>
      <input
        v-model="rUsername"
        type="text"
        id="rInputUsername"
        class="form-control"
        placeholder="Username"
        required
      />
      <label for="rInputPassword" class="sr-only">Password</label>
      <input
        v-model="rPassword"
        type="password"
        id="rInputPassword"
        class="form-control"
        placeholder="Password"
        required
      />
      <label for="rInputConfirmPassword" class="sr-only">Confirm your password</label>
      <input
        v-model="rConfirmPassword"
        type="password"
        id="rInputConfirmPassword"
        class="form-control"
        placeholder="Confirm your password"
        required
      />
      <button class="btn btn-lg btn-primary btn-block" @click="register">Register</button>
      <button class="btn btn-lg btn-secondary btn-block" @click="login">Sign in</button>
    </form>
  </div>
</template>

<script>
import jwt_decode from "jwt-decode";

export default {
  
  name: "Register",
  data() {
    return {
      infos: null,
      rEmail: "",
      rUsername: "",
      rPassword: "",
      rConfirmPassword: "",
      error: false
    };
  },
  methods: {
    login() {
      this.$router.replace(this.$route.query.redirect || "/");
    },
    register() {
      this.$http
        .post("http://localhost:4000/api/sign_up", {
          user: {
            username: this.rUsername,
            email: this.rEmail,
            password: this.rPassword,
            password_confirmation: this.rConfirmPassword
          }
        })
        .then(request => {
          localStorage.token = request.body.jwt;
          console.log("register okay");
          
          var decoded = jwt_decode(localStorage.token);
          localStorage.userId = decoded.sub[0];
          console.log("before");
          
          this.registerSuccessful(request);
        })
        .catch(() => this.registerFailed());
    },
    getClock() {
      this.$http
        .get("http://127.0.0.1:4000/api/clocks/" + localStorage.userId, {
          headers: { Authorization: `Bearer ${localStorage.token}` }
        })
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
          if (this.infos.length != 0) localStorage.status = true;
          else localStorage.status = false;
        })
        .catch(e => console.log(e));
    },
    getUser() {
      this.$http
        .get("http://127.0.0.1:4000/api/users/" + localStorage.userId, {
          headers: { Authorization: `Bearer ${localStorage.token}` }
        })
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
          localStorage.role = this.infos.role;
        })
        .catch(e => console.log(e));
    },
    registerSuccessful(req) {
      if (!req.body.jwt) {
        this.registerFailed();
        return;
      }
      this.error = false;
      console.log("no error");
      
      this.$router.replace(this.$route.query.redirect || "/dashboard");
    },
    registerFailed() {
      this.error = "Sign up failed!";
      delete localStorage.token;
    }
  }
};
</script>

<style>
body {
  background: #605b56;
}

.login-wrapper {
  background: #fff;
  width: 70%;
  margin: 12% auto;
}

.form-signin {
  max-width: 330px;
  padding: 10% 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: normal;
}
.form-signin .form-control {
  position: relative;
  height: auto;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  padding: 10px;
  font-size: 16px;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>