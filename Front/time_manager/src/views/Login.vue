<template>
  <div class="login-wrapper border border-light">
    <form class="form-signin" @submit.prevent="login">
      <h2 class="form-signin-heading">Please sign in</h2>
      <div class="alert alert-danger" v-if="error">{{ error }}</div>
      <label for="inputEmail" class="sr-only">Email address</label>
      <input
        v-model="email"
        type="email"
        id="inputEmail"
        class="form-control"
        placeholder="Email address"
        required
        autofocus
      />
      <label for="inputPassword" class="sr-only">Password</label>
      <input
        v-model="password"
        type="password"
        id="inputPassword"
        class="form-control"
        placeholder="Password"
        required
      />
      <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      <button class="btn btn-lg btn-secondary btn-block" @click="register">Register</button>
    </form>
  </div>
</template>

<script>
import jwt_decode from "jwt-decode";

export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      error: false
    };
  },
  methods: {
    login() {
      this.$http
        .post("http://localhost:4000/api/sign_in", {
          email: this.email,
          password: this.password
        })
        .then(request => this.loginSuccessful(request))
        .catch(() => this.loginFailed());
    },
    register() {
      this.$router.replace(this.$route.query.redirect || "/register");
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
    loginSuccessful(req) {
      if (!req.body.jwt) {
        this.loginFailed();
        return;
      }
      localStorage.token = req.body.jwt;
      var decoded = jwt_decode(localStorage.token);
      localStorage.userId = decoded.sub[0];
      this.getUser();
      localStorage.surname = decoded.sub[1];
      localStorage.mail = decoded.sub[2];
      this.getClock();

      this.error = false;

      this.$router.replace(this.$route.query.redirect || "/dashboard");
    },
    loginFailed() {
      this.error = "Login failed!";
      delete localStorage.token;
    }
  }
};
</script>

<style scoped>
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
