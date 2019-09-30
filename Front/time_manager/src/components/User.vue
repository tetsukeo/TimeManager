<template>
  <div>
    <b-button @click="logout" variant="outline-primary">log out</b-button>

    <div style="     margin: 0 auto; width: 25%; margin-top: 10%; padding-bottom: 10%;">
      <img class="avatar" src="./../assets/imgs/profile.jpeg" />
    </div>
    <div class="user-info border border-secondary">
      <div>
        <p>Username :</p>
        <p>UserId :</p>
        <p>Mail :</p>
        <p>Role :</p>
        <p>Team :</p>
        <p>Status :</p>
      </div>
      <div>
        <p class="userline">{{infoUser.surname}}</p>
        <p class="userline">{{infoUser.id}}</p>
        <p class="userline">{{infoUser.mail}}</p>
        <p class="userline">{{infoUser.role}}</p>
        <p class="userline">{{infoUser.teamName}}</p>

        <p class="userline" v-if="infoUser.status">Working</p>
        <p class="userline" v-if="!infoUser.status">Not working</p>
      </div>

      <div class="item-a pos-text">
        <b-button @click="setValue" v-b-modal.modal-prevent-closing variant="outline-primary">Edit</b-button>

        <b-modal
          id="modal-prevent-closing"
          ref="modal"
          title="Submit Your Name"
          @show="resetModal"
          @hidden="resetModal"
          @ok="handleOk"
        >
          <form ref="form" @submit.stop.prevent="handleSubmit">
            <b-form-group
              :state="nameState"
              label="Surname"
              label-for="name-input"
              invalid-feedback="Surname is required"
            >
              <b-form-input
                v-model="tmpInfoUser.surname"
                id="name-input"
                :state="nameState"
                required
              ></b-form-input>
            </b-form-group>
            <b-form-group
              :state="mailState"
              label="Mail"
              label-for="mail-input"
              invalid-feedback="Mail is required"
            >
              <b-form-input v-model="tmpInfoUser.mail" id="mail-input" :state="mailState" required></b-form-input>
            </b-form-group>
            <b-form-group
              :state="teamState"
              label="Team"
              label-for="team-input"
              invalid-feedback="Team not exist"
            >
              <b-form-input v-model="tmpInfoUser.team" id="team-input" :state="teamState"></b-form-input>
            </b-form-group>
          </form>
        </b-modal>
      </div>
    </div>

    <div style="display: grid; grid-tempalte-rows: 40% 20%;">
      <ColorPicker
        class="color-choice"
        :width="300"
        :height="300"
        :disabled="false"
        startColor="#ff0000"
        @color-change="onColorChange"
      ></ColorPicker>
      <div style="margin: 20px auto">
        <b-button @click="setColor" variant="outline-primary">Emit</b-button>
      </div>
      <div style="margin: 20px auto">
        <b-button @click="createTeam" variant="outline-primary">Create team</b-button>
        <div>
          <b-form-input v-model="teamName" placeholder="Enter team name"></b-form-input>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
}
.color-choice {
  margin-top: 30px;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 30px;
  display: block;
}

.pos-text {
  display: block;
  margin: auto;
}

.item-a {
  grid-column: span 2;
  grid-row: 2;
}

.user-info {
  padding: 20px;
  display: grid;
  grid-template-columns: 30% 65%;
  grid-gap: 20px;
  margin: 0 auto;
  width: 80%;
}

.userline {
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
}

.center * {
  text-align: center;
}
</style>

<script>
import ColorPicker from "vue-color-picker-wheel";
import store from "./../store";
import Axios from "axios";
import { log } from "util";

export default {
  name: "User",
  data() {
    return {
      teams: [],
      name: "",
      teamName: "",
      nameState: null,
      mailState: null,
      teamState: null,
      submittedNames: [],
      info: [],
      color: store.state.color,
      tmpInfoUser: {
        surname: "",
        mail: "",
        team: ""
      },
      infos: null
    };
  },
  props: {
    infoUser: {
      type: Object
    }
  },
  components: {
    ColorPicker
  },
  methods: {
    logout() {
      this.$router.replace(this.$route.query.redirect || "/");
    },
    makeToast(variant = null, title, message) {
      this.$bvToast.toast(message, {
        title: `${title || "default"}`,
        variant: variant,
        solid: true
      });
    },
    createTeam() {
      if (this.teamName == "") {
        this.makeToast("danger", "Error", "The name of team cannot be null");
        return;
      }
      Axios.post(
        "http://127.0.0.1:4000/api/teams",
        { team: { name: this.teamName } },
        {
          headers: { Authorization: `Bearer ${localStorage.token}` }
        }
      )
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
          this.makeToast(
            "success",
            "Success",
            "The team " + this.infos.name + " created"
          );
        })
        .catch(e => console.log(e));
    },
    setUser() {
      this.infoUser.id = localStorage.userId;
      this.infoUser.surname = localStorage.surname;
      this.infoUser.mail = localStorage.mail;
      this.infoUser.status = localStorage.status;
      this.infoUser.role = localStorage.role;
    },
    getClocks() {
      Axios.get("http://127.0.0.1:4000/api/clocks/" + this.infoUser.id, {
        headers: { Authorization: `Bearer ${localStorage.token}` }
      })
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
          if (this.infos.length != 0) this.infoUser.status = true;
          else this.infoUser.status = false;

          this.vue = true;
        })
        .catch(e => console.log(e));
    },
    setColor() {
      this.$emit("setColor", this.color);
    },
    onColorChange(color) {
      this.color = color;
    },
    checkFormValidity() {
      const validName = this.$refs.form.checkValidity();
      this.nameState = validName ? true : false;
      const validMail = this.validEmail(this.tmpInfoUser.mail);
      this.mailState = validMail ? true : false;
      if (validMail && validName) return true;
      return false;
    },
    resetModal() {
      this.mailState = null;
      this.nameState = null;
      this.teamState = null;
    },
    handleOk(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault();
      // Trigger submit handler
      this.handleSubmit();
    },
    setTeamsUser() {
      let i = 0;
      let find = false;
      while (this.teams.length > i && find == false) {
        if (
          this.tmpInfoUser.team == this.teams[i].id ||
          this.tmpInfoUser.team == this.teams[i].name
        ) {
          let k = i;
          find = true;
          Axios.post(
            "http://127.0.0.1:4000/api/teams/" +
              this.teams[k].id +
              "/members/" +
              this.infoUser.id,
            {} ,
            {
              headers: { Authorization: `Bearer ${localStorage.token}` }
            }
          )
            .then(response => {
              console.log("okay");
              console.log(this.teams[k]);
              
              this.updateUser();
              
              this.infoUser.mail = this.tmpInfoUser.mail;
              this.infoUser.surname = this.tmpInfoUser.surname;
              this.infoUser.teamName = this.teams[k].name;
              localStorage.username = this.infoUser.surname;
              localStorage.mail = this.infoUser.mail;
              return;
            })
            .catch(e => console.log(e));
        }
        i++;
      }
      this.tmpInfoUser.team = "";
      if (find == false) {
      this.makeToast("danger", "Error", "Team not found");
      }
    },
    setTeam() {
      Axios.get("http://127.0.0.1:4000/api/teams", {
        headers: { Authorization: `Bearer ${localStorage.token}` }
      })
        .then(response => {
          this.teams = JSON.stringify(response.data);
          this.teams = JSON.parse(this.teams);
          if (this.teams.length != 0) this.setTeamsUser();
          else {
            this.makeToast("danger", "Error", "No team");
            return;
          }
        })
        .catch(e => console.log(e));
    },
    updateUser() {
      Axios.put(
        "http://127.0.0.1:4000/api/users/" + this.infoUser.id,
        {
          user: {
            username: this.tmpInfoUser.surname,
            email: this.tmpInfoUser.mail
          }
        },
        {
          headers: { Authorization: `Bearer ${localStorage.token}` }
        }
      )
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
        })
        .catch(e => console.log(e));
    },
    handleSubmit() {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return;
      }
      if (this.tmpInfoUser.team != "") {
        this.setTeam();
      } else {
        this.updateUser();
        this.infoUser.mail = this.tmpInfoUser.mail;
        this.infoUser.surname = this.tmpInfoUser.surname;
        localStorage.username = this.infoUser.surname;
        localStorage.mail = this.infoUser.mail;
      }
      // Hide the modal manually
      this.$nextTick(() => {
        this.$refs.modal.hide();
      });
    },
    setValue() {
      this.tmpInfoUser.surname = this.infoUser.surname;
      this.tmpInfoUser.mail = this.infoUser.mail;

      this.tmpInfoUser.team = this.infoUser.teamName;
    },
    validEmail: function(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    }
  },
  mounted() {
    console.log(this.infoUser);
    
  }
};
</script>
