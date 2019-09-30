<template>
  <div>
    <SearchBar @setUser="setUser"></SearchBar>
    <div class="user-info" v-if="vue">
      <div>
        <p>Username :</p>
        <p>UserId :</p>
        <p>Mail :</p>
        <p>Role :</p>
        <p>Team :</p>

        <p>Status :</p>
      </div>
      <div>
        <p class="userline">{{infoUserManager.surname}}</p>
        <p class="userline">{{infoUserManager.id}}</p>
        <p class="userline">{{infoUserManager.mail}}</p>
        <p class="userline">{{infoUserManager.role}}</p>
        <p class="userline">{{infoUserManager.teamName}}</p>

        <p class="userline" v-if="infoUserManager.status">Working</p>
        <p class="userline" v-if="!infoUserManager.status">Not working</p>
      </div>
      <div class="item-a pos-text">
        <b-button
          @click="setEmployee"
          v-b-modal.modal-prevent-closing-manager
          variant="outline-primary"
        >Edit</b-button>

        <b-modal
          id="modal-prevent-closing-manager"
          ref="modalManager"
          title="our Name"
          @show="resetManager"
          @hidden="resetManager"
          @ok="handleOkManager"
        >
          <form ref="formManager" @submit.stop.prevent="handleSubmitManager">
            <b-form-group
              :state="nameStateManager"
              label="Surname"
              label-for="name-input"
              invalid-feedback="Surname is required"
            >
              <b-form-input
                v-model="tmpInfoUserManager.surname"
                id="name-input"
                :state="nameStateManager"
                required
              ></b-form-input>
            </b-form-group>
            <b-form-group
              :state="mailStateManager"
              label="Mail"
              label-for="mail-input"
              invalid-feedback="Mail is required"
            >
              <b-form-input
                v-model="tmpInfoUserManager.mail"
                id="mail-input"
                :state="mailStateManager"
                required
              ></b-form-input>
            </b-form-group>
            <b-form-group
              :state="roleStateManager"
              label="Role"
              label-for="role-input"
              invalid-feedback="Role is required"
            >
              <b-form-input
                v-model="tmpInfoUserManager.role"
                id="role-input"
                :state="roleStateManager"
                required
              ></b-form-input>
            </b-form-group>
            <b-form-group
              :state="mailStateManager"
              label="Mail"
              label-for="mail-input"
              invalid-feedback="Mail is required"
            >
              <b-form-input
                v-model="tmpInfoUserManager.mail"
                id="mail-input"
                :state="mailStateManager"
                required
              ></b-form-input>
            </b-form-group>
            <b-form-group
              :state="teamStateManager"
              label="Team"
              label-for="team-input"
              invalid-feedback="Team not exist"
            >
              <b-form-input
                v-model="tmpInfoUserManager.team"
                id="team-input"
                :state="teamStateManager"
              ></b-form-input>
            </b-form-group>
          </form>
        </b-modal>
      </div>
    </div>
  </div>
</template>

<script>
import SearchBar from "./../components/SearchBar";
import Axios from "axios";

export default {
  name: "userManager",
  components: { SearchBar },
  data() {
    return {
      teams: [],
      vue: false,
      nameStateManager: null,
      roleStateManager: null,
      mailStateManager: null,
      teamStateManager: null,
      submittedNames: [],
      info: null,
      infoUserManager: {
        surname: "test surname",
        mail: "test@mail.com",
        id: "2",
        status: false,
        role: "",
        teamName:""
      },
      tmpInfoUserManager: {
        surname: "",
        mail: "",
        id: "",
        role: "",
        team: "",
        status: false
      }
    };
  },
  methods: {
    makeToast(variant = null, title, message) {
      this.$bvToast.toast(message, {
        title: `${title || "default"}`,
        variant: variant,
        solid: true
      });
    },
    setUser(info) {
      this.infoUserManager.surname = info.username;
      this.infoUserManager.mail = info.email;
      this.infoUserManager.id = info.id;
      this.infoUserManager.role = info.role;
      this.infoUserManager.teamName = "azer";
      this.getClock();
    },
    getClock() {
      Axios.get("http://127.0.0.1:4000/api/clocks/" + this.infoUserManager.id, {
        headers: { Authorization: `Bearer ${localStorage.token}` }
      })
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
          if (this.infos.length !== 0) this.infoUserManager.status = true;
          else this.infoUserManager.status = false;
          this.vue = true;
        })
        .catch(e => console.log(e));
    },
    checkFormValidity() {
      const validNameManager = this.$refs.formManager.checkValidity();
      this.nameStateManager = validNameManager ? true : false;
      const validMailManager = this.validEmail(this.tmpInfoUserManager.mail);
      this.mailStateManager = validMailManager ? true : false;

      if (validMailManager && validNameManager) return true;
      return false;
    },
    resetManager() {
      this.mailStateManager = null;
      this.nameStateManagers = null;
      this.teamStateManager = null;
    },
    handleOkManager(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault();
      // Trigger submit handler
      this.handleSubmitManager();
    },
    updateUser() {
      Axios.put(
        "http://127.0.0.1:4000/api/users/" + this.infoUserManager.id,
        {
          user: {
            username: this.tmpInfoUserManager.surname,
            email: this.tmpInfoUserManager.mail
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
    setTeamsUser() {
      let i = 0;
      let find = false;
      while (this.teams.length > i && find == false) {
        if (
          this.tmpInfoUserManager.team == this.teams[i].id ||
          this.tmpInfoUserManager.team == this.teams[i].name
        ) {
          find = true;
          Axios.post(
            "http://127.0.0.1:4000/api/teams/" +
              this.teams[i].id +
              "/members/" +
              this.infoUserManager.id,
            {},
            {
              headers: { Authorization: `Bearer ${localStorage.token}` }
            }
          )
            .then(response => {
              this.updateUser();
              this.infoUserManager.mail = this.tmpInfoUserManager.mail;
              this.infoUserManager.surname = this.tmpInfoUserManager.surname;
              this.infoUserManager.teamName = this.team[i].name;
              localStorage.username = this.infoUserManager.surname;
              localStorage.mail = this.infoUserManager.mail;
              return;
            })
            .catch(e => console.log("lol"));
        }
        i++;
      }
      this.tmpInfoUserManager.team = "";
      this.makeToast("danger", "Error", "Team not found");
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
    handleSubmitManager() {
      // Exit when the form isn't valid
      if (!this.checkFormValidity()) {
        return;
      }
      this.setTeam();
      this.infoUserManager.mail = this.tmpInfoUserManager.mail;
      this.infoUserManager.surname = this.tmpInfoUserManager.surname;

      // Hide the modal manually

      this.$nextTick(() => {
        this.$refs.modalManager.hide();
      });
    },
    setEmployee() {
      this.tmpInfoUserManager.surname = this.infoUserManager.surname;
      this.tmpInfoUserManager.mail = this.infoUserManager.mail;
      this.tmpInfoUserManager.role = this.infoUserManager.role;
    },
    validEmail: function(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    }
  }
};
</script>



<style scoped>
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